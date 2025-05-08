import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srs_system/utils/constants/colors.dart';
import '../../data/models/specialist_model.dart';
import '../../utils/helpers/helpers.dart';
import '../screens/booking_screen.dart';
import 'common/custom_rounded_container.dart';

class SpecialistView extends StatelessWidget {
  const SpecialistView({super.key, this.specialist});
  final SpecialistModel? specialist;

  @override
  Widget build(BuildContext context) {
    return CustomRoundedContainer(
      backgroundColor: const Color.fromARGB(255, 66, 66, 66),
      enableBorder: true,
      borderColor: MyColors.appBarColor,
      height: 100,
      width: MyHelpers.getScreenWidth(context),
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(10),
      onTap: () {
        Get.to(() => BookingScreen(specialist: specialist!));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // -- Left side: Name and Specialization
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  specialist!.name ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  specialist!.specialization ?? '',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // -- Right side: Availability and Specialization
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // -- Date Availabilty
                Text(
                  "Available Dayes",
                  style: TextStyle(
                    color: MyColors.appBarColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  specialist!.availability.keys.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
