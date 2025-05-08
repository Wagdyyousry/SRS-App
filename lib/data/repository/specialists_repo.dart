import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:srs_system/data/models/booking_model.dart';

import '../models/specialist_model.dart';

class SpecialistsRepo {
  final FirebaseFirestore mDatabase = FirebaseFirestore.instance;
  final FirebaseAuth mAuth = FirebaseAuth.instance;

  Future<List<SpecialistModel>> getAllSpecialists() async {
    final snapshot = await mDatabase.collection('Specialists').get();
    final list = snapshot.docs
        .map((doc) => SpecialistModel.fromMap(doc.data()))
        .toList();
    return list;
  }

  Future<List<BookingModel>> getMyBookings() async {
    final snapshot = await mDatabase.collection('Bookings').get();
    final myBooking = <BookingModel>[];
    final list = snapshot.docs.map((doc) {
      return BookingModel.fromMap(doc.data());
    }).toList();
    for (var booking in list) {
      if (booking.userId! == mAuth.currentUser!.uid) {
        myBooking.add(booking);
      }
    }
    return myBooking;
  } 
  
}
