import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:srs_system/data/controllers/specialists_controller.dart';
import 'package:srs_system/utils/helpers/helpers.dart';
import 'package:srs_system/utils/loaders/loaders.dart';
import '../../data/models/booking_model.dart';
import '../../utils/constants/colors.dart';
import 'common/custom_rounded_container.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key, required this.singleBook});

  final BookingModel singleBook;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat("dd-MM-yyyy");
    final bookingDate = df.format(singleBook.date);
    final controller = Get.put(SpecialistsController());
    return CustomRoundedContainer(
      height: 70,
      enableBorder: true,
      borderColor: MyColors.appBarColor,
      child: ListTile(
        // -- Specialists Name
        title: Text(
          singleBook.doctorName != null ? singleBook.doctorName! : "",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        // -- Specialization
        subtitle: Text(
          singleBook.doctorSpecialization != null
              ? singleBook.doctorSpecialization!
              : "",
          style: TextStyle(
            color: MyColors.appBarColor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 10,
          ),
        ),

        titleAlignment: ListTileTitleAlignment.center,
        // -- Cancle Booking Button
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Warning... ",
                    style: TextStyle(
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  content: Text("Are sure you want to cancle the Booking?"),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await controller.cancleBooking(singleBook);
                        await controller.getMyBookings();
                        Get.back();
                        MyLoaders.successSnackBar(
                            message:
                                "The booking in $bookingDate are cancled successfully");
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(
            Icons.cancel,
            size: 30,
            color: Colors.red,
          ),
        ),
        // -- Booking Date And Time
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              bookingDate,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "${MyHelpers.convertWeekdayToDayName(singleBook.date.weekday)}/${singleBook.time}",
              style: TextStyle(
                color: MyColors.appBarColor,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
