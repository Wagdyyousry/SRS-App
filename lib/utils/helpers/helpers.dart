import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyHelpers {
  MyHelpers._();
  static double myRedmiHeight = 803.63,
      myRedmiWidth = 392.72,
      myEmulatorHeight = 640.0,
      myEmulatorWidth = 360.0;

  static Color? getColor(String value) {
    /// --- Define your product specific colors
    switch (value) {
      case 'green':
        return Colors.green;
      case 'lightGreen':
        return Colors.lightGreen;
      case 'darkGreen':
        return const Color.fromARGB(255, 13, 44, 15);

      case 'red':
        return Colors.red;
      case 'lightRed':
        return const Color.fromARGB(255, 236, 92, 81);
      case 'darkRed':
        return const Color.fromARGB(255, 73, 13, 8);

      case 'blue':
        return Colors.blue;
      case 'lightBlue':
        return const Color.fromARGB(255, 79, 166, 238);
      case 'darkBlue':
        return const Color.fromARGB(255, 7, 47, 79);

      case 'pink':
        return Colors.pink;
      case 'darkPink':
        return const Color.fromARGB(255, 73, 6, 28);
      case 'lightPink':
        return const Color.fromARGB(255, 232, 76, 128);

      case 'grey':
        return Colors.grey;
      case 'darkGrey':
        return const Color.fromARGB(255, 83, 83, 83);
      case 'lightGrey':
        return const Color.fromARGB(255, 176, 176, 176);

      case 'purple':
        return Colors.purple;
      case 'lightPurple':
        return const Color.fromARGB(255, 83, 83, 83);
      case 'darkPurple':
        return const Color.fromARGB(255, 77, 10, 89);

      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;

      case 'yellow':
        return Colors.yellow;
      case 'lightYellow':
        return const Color.fromARGB(255, 246, 229, 80);
      case 'darkYellow':
        return const Color.fromARGB(255, 91, 82, 8);

      case 'orange':
        return Colors.orange;
      case 'lightOrange':
        return const Color.fromARGB(255, 224, 105, 69);
      case 'darkOrange':
        return const Color.fromARGB(255, 141, 42, 12);

      case 'brown':
        return Colors.brown;
      case 'lightBrown':
        return const Color.fromARGB(255, 156, 84, 57);
      case 'darkBrown':
        return const Color.fromARGB(255, 65, 33, 21);

      case 'teal':
        return Colors.teal;
      case 'lightTeal':
        return const Color.fromARGB(255, 73, 238, 221);
      case 'darkTeal':
        return const Color.fromARGB(255, 8, 80, 73);

      case 'indigo':
        return Colors.indigo;
      case 'lightIndigo':
        return const Color.fromARGB(255, 100, 120, 232);
      case 'darkIndigo':
        return const Color.fromARGB(255, 22, 30, 70);

      default:
        return null;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(title),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop,
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}.....';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static List<T> removeDublicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static double getResponsiveHeight(double height) {
    double percent = height / myEmulatorHeight;

    double resHeight = percent * getScreenHeight(Get.context!);
    //print("=== real ==> |$height| responsive ==> |$resHeight|");
    return resHeight;
  }

  static double getResponsiveWidth(double width) {
    double percent = width / myEmulatorWidth;

    double resWidth = percent * getScreenWidth(Get.context!);

    //print("=== real ==> |$width| responsive ==> |$resWidth|");

    return resWidth;
  }
   // Helper: convert day name to weekday number
  static int convertDayNameToWeekday(String day) {
    const dayMap = {
      "Sunday": DateTime.sunday,
      "Monday": DateTime.monday,
      "Tuesday": DateTime.tuesday,
      "Wednesday": DateTime.wednesday,
      "Thursday": DateTime.thursday,
      "Friday": DateTime.friday,
      "Saturday": DateTime.saturday,
    };
    return dayMap[day]!;
  }

  static String convertWeekdayToDayName(int weekday) {
    const dayNames = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
    return dayNames[weekday]!;
  }

  static void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        content: Center(child: Text(' $text \n Copied to clipboard')),
        elevation: 5,
      ),
    );
  }
}
