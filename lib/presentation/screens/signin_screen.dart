import 'package:flutter/material.dart';
import '../../utils/constants/my_images.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/texts.dart';
import '../widgets/common/custom_divider.dart';
import '../widgets/common/header_with_image.dart';
import '../widgets/registeration/signin_form.dart';
import '../widgets/registeration/social_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySizes.defaultSpace),
          child: Column(
            children: [
              // -- Logo & Title & SubTitle
              SizedBox(height: MySizes.spaceBtwSections),
              HeaderWithImage(
                logo: MyImages.logo2,
                title: MyTexts.loginTitle,
                subtitle: MyTexts.loginSubTitle,
              ),

              // -- Form fields
              SignInForm(),

              // -- Devider
              CustomDivider(centertitle: MyTexts.orSignInwith),
              SizedBox(height: MySizes.spaceBtwSections),

              // -- Footer & Other Registeration Methods
              SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
