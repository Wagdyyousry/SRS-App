import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/my_images.dart';
import '../constants/sizes.dart';
import '../helpers/helpers.dart';

class MyLoaders {
  MyLoaders._();
static void openLoadingDialog({
    String text = "",
    String image = MyImages.onBordingScreenImage5,
  }) {
    if (text.isNotEmpty && text != "") {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) => Dialog(
          child: Container(
            height: 220,
            decoration: BoxDecoration(
              color: MyHelpers.isDarkMode(context)
                  ? MyColors.dark
                  : MyColors.light,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // -- message
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // -- image
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(image),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    // -- dialog with out Title
    else {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (context) => Dialog(
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: MyHelpers.isDarkMode(context)
                  ? MyColors.dark
                  : MyColors.light,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(image),
              ),
            ),
          ),
        ),
      );
    }
  }

  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
  
  static void successSnackBar({title = "Success", message = "", duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.blue,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
    );
  }

  static void warningSnackBar({title = "Warning", message = "", duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }

  static void errorSnackBar({title = "Error, ", message = "", duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Icons.error_outline, color: Colors.white),
    );
  }

  static void customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        elevation: 10,
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Success",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  
  
  /// Delete Account Warning
  static void warningDialogWithButton({
    String title = 'Delete Account',
    String message = '',
    VoidCallback? onPressed,
  }) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(MySizes.md),
      title: title,
      middleText: message,
      confirm: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: MySizes.lg),
          child: Text('Confirm'),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.context!).pop(),
      ),
    );
  }
}
