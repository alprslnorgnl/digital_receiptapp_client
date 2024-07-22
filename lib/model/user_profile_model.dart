import 'dart:io';

class UserProfileModel {
  String name;
  String surname;
  String email;
  String gender;
  DateTime birthDate;
  File profileImage;

  UserProfileModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.profileImage,
  });
}
