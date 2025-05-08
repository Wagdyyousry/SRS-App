class BookingModel {
  final String? bookingId, specialistId, userId, time, userName, doctorName,doctorSpecialization;
  final DateTime date;

  BookingModel({
     this.bookingId,
     this.specialistId,
     this.userId,
     required this.date,
     this.time,
     this.userName,
     this.doctorName,
     this.doctorSpecialization,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingId': bookingId,
      'specialistId': specialistId,
      'userId': userId,
      'date': date.toIso8601String(),
      'time': time,
      'userName': userName,
      'doctorName': doctorName,
      'doctorSpecialization': doctorSpecialization,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      bookingId: map['bookingId'],
      specialistId: map['specialistId'],
      userId: map['userId'],
      date: DateTime.parse(map['date']),
      time: map['time'],
      userName: map['userName'],
      doctorName: map['doctorName'],
      doctorSpecialization: map['doctorSpecialization'],
    );
  }
}
