import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/texts.dart';
import '../../utils/loaders/loaders.dart';
import '../models/user_model.dart';
import '../repository/registration_repo.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  // -- variables
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  late final FirebaseFirestore mFirestore;
  late RegisterationRepo myRepo;

  // -- Variables for input fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  @override
  void onInit() {
    super.onInit();
    myRepo = RegisterationRepo();
    mFirestore = FirebaseFirestore.instance;
  }

  // -- Sign Up Method
  Future<void> signUp() async {
    try {
      // -- Check Form Validation
      if (!formKey.currentState!.validate()) return;

      // -- check privacy policy
      if (!privacyPolicy.value) {
        MyLoaders.warningSnackBar(
          title: MyTexts.acceptPrivacy,
          message: MyTexts.acceptPrivacyCon,
        );
        return;
      }

      // -- Create New User
      await createNewUser();
    } catch (e) {
      MyLoaders.errorSnackBar(title: "Error : ", message: e.toString());
    }
  }

  Future<void> createNewUser() async {

    UserModel user = UserModel(
      name: "${firstName.text} ${lastName.text}",
      email: email.text,
      password: password.text,
      phoneNumber: phoneNumber.text,
      userId: "",
    );

    await myRepo.createNewUser(user);
  }
}

