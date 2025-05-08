import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:srs_system/data/repository/specialists_repo.dart';

import '../models/booking_model.dart';
import '../models/specialist_model.dart';

class SpecialistsController extends GetxController {
  static SpecialistsController get instance => Get.find();
  final FirebaseFirestore mDatabase = FirebaseFirestore.instance;
  final FirebaseAuth mAuth = FirebaseAuth.instance;
  late SpecialistsRepo myRepo;
  final allSpecialists = <SpecialistModel>[].obs;
  final searchedSpecialists = <SpecialistModel>[].obs;
  final filterSpecialistsName = <SpecialistModel>[].obs;
  final filterSpecialistsCategory = <SpecialistModel>[].obs;
  final myBookingList = <BookingModel>[].obs;

  @override
  onInit() {
    super.onInit();
    myRepo = SpecialistsRepo();
    getSpecialists();
    getMyBookings();
  }

  Future<void> getSpecialists() async {
    allSpecialists.value = await myRepo.getAllSpecialists();
    filterAllSpecialists();
  }

  Future<void> filterSpecialists(String query) async {
    searchedSpecialists.value = [];
    for (var spec in allSpecialists) {
      if (spec.name!.toLowerCase().contains(query) ||
          spec.specialization!.toLowerCase().contains(query)) {
        searchedSpecialists.add(spec);
      }
    }
  }

  Future<void> storeBooking(BookingModel bookingModel) async {
    final bookingId = DateTime.now().millisecondsSinceEpoch.toString();

    await FirebaseFirestore.instance
        .collection('Bookings')
        .doc(bookingId)
        .set(bookingModel.toMap());
  }

  Future<void> getMyBookings() async {
    myBookingList.value = await myRepo.getMyBookings();
  }

  Future<void> cancleBooking(BookingModel bookingModel) async {
    await mDatabase.collection('Bookings').doc(bookingModel.bookingId).delete();
  }

  // -- Filter All Specialists
  void filterAllSpecialists() {
    print("====>> ${allSpecialists.toString()}");

    filterSpecialistsCategory.value = [];
    filterSpecialistsName.value = [];
    if (allSpecialists.isNotEmpty) {
      for (var spec in allSpecialists) {
        filterSpecialistsName.add(spec);
        filterSpecialistsCategory.add(spec);
      }
      filterSpecialistsName.sort((a, b) => a.name!.compareTo(b.name!));
      print("====>> ${filterSpecialistsName.toString()}");
      filterSpecialistsCategory
          .sort((a, b) => b.specialization!.compareTo(a.specialization!));
      print("====>> ${filterSpecialistsCategory.toString()}");
    }
  }
}
