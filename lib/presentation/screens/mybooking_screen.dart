import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/controllers/specialists_controller.dart';
import '../../presentation/widgets/appBar_widget.dart';
import '../../presentation/widgets/common/custom_listview.dart';
import '../widgets/booking_view.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  late final SpecialistsController controller;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpecialistsController());
    controller.getMyBookings();
    return Scaffold(
      appBar: AppBarWidget(title: "My Bookings"),
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Obx(
          () => controller.myBookingList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : CustomListView(
                  scroll: false,
                  separatorBuilder: (context, index) => SizedBox(height: 5),
                  itemCount: controller.myBookingList.length,
                  itemBuilder: (context, index) {
                    final singleBook = controller.myBookingList[index];
                    return BookingView(singleBook: singleBook);
                  },
                ),
        ),
      ),
    );
  }
}
