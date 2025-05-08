import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../../data/controllers/signin_controller.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../screens/signup_screen.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MySizes.spaceBtwSections),
        child: Column(
          children: [
            // -- Email
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(MySizes.focusedBorderRadius)),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                prefixIcon: Icon(Icons.email),
                labelText: MyTexts.email,
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwInputFields),

            // -- Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(MySizes.focusedBorderRadius),
                    ),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                  labelText: MyTexts.password,
                ),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwInputFields / 3),

            // -- Forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text(
                    "Forget password",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: MySizes.spaceBtwSections),

            // -- Sign in button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signInWithEmailAndPassword(),
                child: const Text(MyTexts.signIn),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwItems),

            // -- Create New Acount button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(MyTexts.createAccount),
              ),
            ),
            const SizedBox(height: MySizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
