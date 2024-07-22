import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:receipt_app/view/components/appbarWithArrow.dart';
import 'package:receipt_app/view/screens/successPasswordChangeSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../constants/colors.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmController = TextEditingController();

  void _changePassword() async {
    final String newPassword = _newPasswordController.text;
    final String newPasswordConfirm = _newPasswordConfirmController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final url =
        Uri.parse('http://35.202.100.38:8080/api/BaseUser/changePassword');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'newPassword': newPassword,
        'newPasswordConfirm': newPasswordConfirm,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Password changed successfully');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SuccessPasswordChangeSettings()));
    } else {
      // Handle error response
      final responseBody = jsonDecode(response.body);
      print(responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppbarWithArrow(
                appbarText: "ŞİFRE DEĞİŞTİR", detailPage: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "ŞİFRENİ DEĞİŞTİR",
                    style: TextStyle(
                      fontFamily: "MontserratExtraBold",
                      fontSize: 30.0,
                      color: HexColor(fontColor1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Şifrenizi değiştirmek için aşağıdaki kutucuğa yeni şifrenizi giriniz",
                        style: TextStyle(
                          fontFamily: "MontserratLight",
                          fontSize: 16.0,
                          color: HexColor(fontColor1),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: TextFormField(
                      obscureText: true,
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                        labelText: "Yeni şifreniz",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _newPasswordConfirmController,
                    decoration: InputDecoration(
                      labelText: "Yeni şifrenizi onaylayınız",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: _changePassword,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(buttonColor1)),
                      child: Text(
                        "Devam et",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18.0,
                          color: HexColor(fontColor2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
