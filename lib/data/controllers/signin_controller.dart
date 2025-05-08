import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/registration_repo.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  // -- Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();
  final resetEmail = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();

  final hidePassword = true.obs;
  late FirebaseAuth mAuth;
  late RegisterationRepo myRepo;

  @override
  onInit() {
    super.onInit();
    mAuth = FirebaseAuth.instance;
    myRepo = RegisterationRepo();
  }

  Future<void> signInWithEmailAndPassword() async {
    if (formKey.currentState!.validate()) {
      await myRepo.signIn(email: email.text, password: password.text);
    }
  }

}
