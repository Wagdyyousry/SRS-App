import 'package:flutter/material.dart';
import '../../../utils/constants/my_images.dart';
import '../common/custom_circular_image.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // -- Google icon
        CustomCircularImage(
          width: 50,
          height: 50,
          isNetworkImage: false,
          image: MyImages.googleIcon,
          enableBorder: true,
          borderColor: Colors.grey,
          onPressed: () {},
        ),

        // -- FaceBook icon
        const CustomCircularImage(
          width: 50,
          height: 50,
          enableBorder: true,
          borderColor: Colors.grey,
          isNetworkImage: false,
          image: MyImages.facebookIcon,
        ),

        // -- Twitter icon
        const CustomCircularImage(
          width: 50,
          height: 50,
          enableBorder: true,
          borderColor: Colors.grey,
          isNetworkImage: false,
          image: MyImages.twitterIcon,
        ),
      ],
    );
  }
}
