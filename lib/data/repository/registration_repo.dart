import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:srs_system/presentation/screens/home_page.dart';
import 'dart:async';

import '../../utils/constants/texts.dart';
import '../../utils/loaders/loaders.dart';
import '../models/user_model.dart';

class RegisterationRepo extends GetxController {
  static RegisterationRepo get instance => Get.find();
  late final FirebaseAuth mAuth;
  late final FirebaseFirestore mFirestore;

  RegisterationRepo() {
    mAuth = FirebaseAuth.instance;
    mFirestore = FirebaseFirestore.instance;
  }

  Future<void> signIn({required String email, required String password}) async {
    MyLoaders.openLoadingDialog();
    try {
      await mAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((onValue) {
        MyLoaders.customToast(message: "Welcom again my friend");
        MyLoaders.openLoadingDialog();
        Get.offAll(() => const HomePage());
      });
    } on FirebaseAuthException catch (e) {
      MyLoaders.stopLoading();
      MyLoaders.errorSnackBar(message: e.toString());
    } catch (e) {
      MyLoaders.stopLoading();
      MyLoaders.errorSnackBar(message: e.toString());
    }
  }

  Future<void> createNewUser(UserModel userData) async {
    // -- Start Loading
    MyLoaders.openLoadingDialog();

    try {
      await mAuth
          .createUserWithEmailAndPassword(
              email: userData.email!, password: userData.password!)
          .then((v) async {
        await storeUserData(userData, MyTexts.emailAndPass);
      });
    } catch (e) {
      MyLoaders.errorSnackBar(message: e);
    }
  }

  Future<void> storeUserData(UserModel userData, String typeOfSignIn) async {
    userData.userId = mAuth.currentUser!.uid;
    await mFirestore.collection("Users").doc(userData.userId).set({
      "name": userData.name,
      "email": userData.email,
      "password": userData.password,
      "phoneNumber": userData.phoneNumber,
      "userId": userData.userId,
      "profileImageUri": userData.profileImageUri,
    }).then((v) {
      Get.off(() => const HomePage());
      MyLoaders.successSnackBar(
        title: "Congratulation",
        message: "Account Created Succesfully",
      );
      
    }).catchError((e) {
      MyLoaders.errorSnackBar(message: e);
    });
  }
}
