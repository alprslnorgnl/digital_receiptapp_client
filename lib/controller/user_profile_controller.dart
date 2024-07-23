import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_profile_model.dart';

class UserProfileController {
  Future<UserProfileModel> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5109/api/BaseUser/get'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      File profileImageFile = File('');
      if (data['profileImage'] != null && data['profileImage'].isNotEmpty) {
        List<int> imageBytes = base64Decode(data['profileImage']);

        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/profile_image.png';

        profileImageFile = File(imagePath)..writeAsBytesSync(imageBytes);
      }

      return UserProfileModel(
        name: data['name'],
        surname: data['surname'],
        email: data['email'],
        gender: data['gender'],
        birthDate: DateTime.parse(data['birthDate']),
        profileImage: profileImageFile,
      );
    } else {
      print("hata ${response.body}");
      throw Exception('Profil bilgileri alınamadı.');
    }
  }

  Future<void> updateUserProfile(UserProfileModel userProfile) async {
    print(userProfile.name.toString());
    print(userProfile.email.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';
    final base64Image =
        base64Encode(userProfile.profileImage.readAsBytesSync());

    final formattedBirthDate = userProfile.birthDate.toIso8601String();

    final response = await http.put(
      Uri.parse('http://10.0.2.2:5109/api/BaseUser/update'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': userProfile.name,
        'surname': userProfile.surname,
        'email': userProfile.email,
        'gender': userProfile.gender,
        'birthDate': formattedBirthDate,
        'profileImage': base64Image,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Profil güncellenirken hata oluştu.');
    }
  }

  Future<void> pickImage(UserProfileModel userProfile) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      userProfile.profileImage = File(pickedFile.path);
    }
  }

  Future<void> selectDate(
      BuildContext context, UserProfileModel userProfile) async {
    final initialDate = userProfile.birthDate.isAfter(DateTime(1900))
        ? userProfile.birthDate
        : DateTime(1900);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != userProfile.birthDate) {
      userProfile.birthDate = picked;
    }
  }
}
