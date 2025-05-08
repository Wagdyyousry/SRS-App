import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:srs_system/data/controllers/specialists_controller.dart';
import 'package:srs_system/data/controllers/user_controller.dart';
import 'package:srs_system/data/models/booking_model.dart';
import 'package:srs_system/presentation/screens/mybooking_screen.dart';
import 'package:srs_system/presentation/widgets/appBar_widget.dart';
import 'package:srs_system/presentation/widgets/common/custom_rounded_container.dart';
import 'package:srs_system/utils/constants/colors.dart';
import 'package:srs_system/utils/helpers/helpers.dart';
import 'package:srs_system/utils/loaders/loaders.dart';
import '../../data/models/specialist_model.dart';

// ignore: must_be_immutable
class BookingScreen extends StatelessWidget {
  final SpecialistModel specialist;
  late SpecialistsController controller;
  late UserController userController;
  BookingScreen({super.key, required this.specialist});

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SpecialistsController());
    userController = Get.put(UserController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWidget(
        title: specialist.specialization ?? 'Specialist',
        actions: [
          IconButton(
            onPressed: () => Get.to(() => MyBookingScreen()),
            icon: Icon(
              Icons.book_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: CustomRoundedContainer(
          borderWidth: 2,
          backgroundColor: const Color.fromARGB(255, 214, 212, 212),
          padding: EdgeInsets.all(20),
          enableBorder: true,
          borderColor: MyColors.appBarColor,
          width: MyHelpers.getScreenWidth(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // -- Name And Specialization and Bio
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        specialist.name!,
                        style: TextStyle(
                          color: MyColors.appBarColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        specialist.specialization!,
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),

                  // -- Bio
                  Flexible(
                    child: Text(
                      '"${specialist.bio!}"',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 133, 133, 133),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // -- Available dayes and times
              CustomRoundedContainer(
                padding: EdgeInsets.all(5),
                radius: 10,
                borderWidth: 1,
                enableBorder: true,
                borderColor: MyColors.appBarColor,
                child: Text(
                  textAlign: TextAlign.center,
                  mixDayWithTime(),
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // -- Book Button
              SizedBox(
                width: MyHelpers.getScreenWidth(context),
                child: ElevatedButton(
                  onPressed: () => pickAvailableDate(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.appBarColor),
                  child: Text("Book an appointment"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Date Picker restricted to available days
  Future<void> pickAvailableDate(BuildContext context) async {
    // Get today's date
    DateTime now = DateTime.now();

    // Find the next available date
    DateTime? nextAvailableDate;
    for (int i = 0; i <= 30; i++) {
      final checkDate = now.add(Duration(days: i));
      final dayName = MyHelpers.convertWeekdayToDayName(checkDate.weekday);
      if (specialist.availability.containsKey(dayName)) {
        nextAvailableDate = checkDate;
        break;
      }
    }

    if (nextAvailableDate == null) {
      // No available date in the next 30 days
      MyLoaders.errorSnackBar(
        message: 'No available dates in the next 30 days',
      );
      return;
    }

    // Now show the date picker using the valid date
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: nextAvailableDate,
      firstDate: now,
      lastDate: now.add(Duration(days: 30)),
      selectableDayPredicate: (date) {
        final dayName = MyHelpers.convertWeekdayToDayName(date.weekday);

        return specialist.availability.containsKey(dayName);
      },
    );

    if (selectedDate != null) {
      final dayName = MyHelpers.convertWeekdayToDayName(selectedDate.weekday);
      List<String> availableTimes = specialist.availability[dayName]!;

      // ignore: use_build_context_synchronously
      availableTimeDialog(context, availableTimes, selectedDate);
    }
  }

  void availableTimeDialog(
      context, List<String> availableTimes, DateTime selectedDate) {
    availableTimes = formatTimeIntervals(availableTimes);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          padding: EdgeInsets.all(16),
          children: availableTimes.map((time) {
            return ListTile(
              title: Text(time),
              onTap: () async {
                Navigator.pop(context);
                final bookingModel = BookingModel(
                  doctorSpecialization: specialist.specialization,
                  bookingId: DateTime.now().millisecondsSinceEpoch.toString(),
                  specialistId: specialist.specialistId!,
                  userId: FirebaseAuth.instance.currentUser!.uid,
                  date: selectedDate,
                  time: "$time:00",
                  userName: userController.userData.value.name!,
                  doctorName: specialist.name!,
                );
                await controller.storeBooking(bookingModel);
                MyLoaders.successSnackBar(message: 'Booking confirmed!');
              },
            );
          }).toList(),
        );
      },
    );
  }

  List<String> formatTimeIntervals(List<String> availableTimes) {
    List<String> fromatTimes = [];
    final firstTime = int.parse(availableTimes[0].split(':')[0]);
    final secondTime = int.parse(availableTimes[1].split(':')[0]);
    final startTime = max(firstTime, secondTime);
    final endTime = min(firstTime, startTime);

    for (int i = endTime; i <= startTime; i++) {
      fromatTimes.add(i.toString());
    }

    return fromatTimes;
  }

  String mixDayWithTime() {
    String daysAndTimes = "";

    specialist.availability.forEach((day, times) {
      if (daysAndTimes != "") {
        daysAndTimes = "$daysAndTimes \n";
      }
      daysAndTimes = "$daysAndTimes $day >> ${times.toString()}";
    });
    return daysAndTimes;
  }

  // -- Alternative solution
  // void availableTimeDialog(BuildContext context,
  //     List<String> availableTimeRanges, DateTime selectedDate) {
  //   // Generate all slots from the ranges
  //   final allSlots = availableTimeRanges
  //       .where((range) => range.contains(',')) // only valid
  //       .expand((range) => generateTimeSlots(range))
  //       .toList();
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return ListView(
  //         padding: const EdgeInsets.all(16),
  //         children: allSlots.map((time) {
  //           return ListTile(
  //             title: Text(
  //               time,
  //               style: TextStyle(color: Colors.black),
  //             ),
  //             onTap: () async {
  //               Navigator.pop(context);
  //               final bookingModel = BookingModel(
  //                 bookingId: DateTime.now().millisecondsSinceEpoch.toString(),
  //                 specialistId: specialist.specialistId!,
  //                 userId: FirebaseAuth.instance.currentUser!.uid,
  //                 date: selectedDate,
  //                 time: time,
  //                 userName: userController.userData.value.name!,
  //                 doctorName: specialist.name!,
  //               );
  //               await controller.storeBooking(bookingModel);
  //               MyLoaders.successSnackBar(message: 'Booking confirmed!');
  //             },
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
  // List<String> generateTimeSlots(String timeRange) {
  //   final parts = timeRange.split(',');
  //   if (parts.length < 2) {
  //     debugPrint('Invalid time range: $timeRange');
  //     return []; // Skip invalid range
  //   }
  //   final start = _parseTimeOfDay(parts[0]);
  //   final end = _parseTimeOfDay(parts[1]);
  //   final List<String> slots = [];
  //   TimeOfDay current = start;
  //   while (_isBefore(current, end)) {
  //     slots.add(_formatTime(current));
  //     current = _addMinutes(current, 30);
  //   }
  //   return slots;
  // }
  // TimeOfDay _parseTimeOfDay(String time) {
  //   final parts = time.split(':');
  //   return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  // }
  // bool _isBefore(TimeOfDay a, TimeOfDay b) {
  //   return a.hour < b.hour || (a.hour == b.hour && a.minute < b.minute);
  // }
  // String _formatTime(TimeOfDay time) {
  //   final hour = time.hour.toString().padLeft(2, '0');
  //   final minute = time.minute.toString().padLeft(2, '0');
  //   return "$hour:$minute";
  // }
  // TimeOfDay _addMinutes(TimeOfDay time, int minutes) {
  //   final totalMinutes = time.hour * 60 + time.minute + minutes;
  //   return TimeOfDay(
  //     hour: totalMinutes ~/ 60,
  //     minute: totalMinutes % 60,
  //   );
  // }
}
