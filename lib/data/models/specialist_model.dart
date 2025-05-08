
class SpecialistModel {
  String? name,
      email,
      password,
      phoneNumber,
      profileImageUri,
      specialistId,
      specialization,
      bio;
  Map<String, List<String>> availability;

  SpecialistModel({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profileImageUri,
    this.specialistId,
    this.specialization,
    this.bio,
    required this.availability,
  });

  factory SpecialistModel.fromMap(Map<String, dynamic> map) {
    Map<String, List<String>> availabilityMap = {};
    if (map['availability'] != null) {
      (map['availability'] as Map<String, dynamic>).forEach((key, value) {
        availabilityMap[key] = List<String>.from(value);
      });
    }

    return SpecialistModel(
        name: map['name'],
        email: map['email'],
        password: map['password'],
        phoneNumber: map['phoneNumber'],
        profileImageUri: map['profileImageUri'],
        specialistId: map['specialistId'],
        specialization: map['specialization'],
        bio: map['bio'],
        availability: availabilityMap);
  }

  // Convert to map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profileImageUri': profileImageUri,
      'specialistId': specialistId,
      'specialization': specialization,
      'bio': bio,
      'availability': availability
    };
  }
}
