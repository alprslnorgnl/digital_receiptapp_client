import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:receipt_app/view/components/otpInput.dart';
import 'package:receipt_app/view/screens/changePhoneNumber.dart';
import 'package:receipt_app/view/screens/successPhoneChangeSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import 'package:http/http.dart' as http;

class ChangePhoneSettingsOtp extends StatefulWidget {
  const ChangePhoneSettingsOtp(
      {super.key, required this.newPhone, required this.oldPhone});

  final String newPhone;
  final String oldPhone;

  @override
  State<ChangePhoneSettingsOtp> createState() => _ChangePhoneSettingsOtpState();
}

class _ChangePhoneSettingsOtpState extends State<ChangePhoneSettingsOtp> {
  String _otpCode = '';

  void _onOtpCompleted(String otp) {
    setState(() {
      _otpCode = otp;
    });
  }

  Future<void> _submitChangePhoneOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final url = Uri.parse(
        'http://35.202.100.38:8080/api/BaseUser/changePhoneOtpV'); // API endpoint URL
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'OtpCode': _otpCode,
        'oldPhoneNumber': widget.oldPhone,
        'newPhoneNumber': widget.newPhone,
      }),
    );

    if (response.statusCode == 200) {
      print('OTP doğrulandı');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SuccessPhoneChangeSettings()));
    } else {
      print('OTP doğrulanamadı');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(
            flex: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "Telefon doğrulama",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18.0,
                color: HexColor(fontColor3),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "OTP kodunu giriniz",
              style: TextStyle(
                fontFamily: "MontserratExtraBold",
                fontSize: 30.0,
                color: HexColor(fontColor1),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "${widget.newPhone} numarasına gönderdiğimiz 6 haneli kodu giriniz",
              style: const TextStyle(
                  fontFamily: "MontserratLight", fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          OtpInput(onCompleted: _onOtpCompleted),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChangePhoneNumber()));
              },
              child: Text(
                "Doğru telefon numarasını girdiğine emin misin?",
                style: TextStyle(
                  fontFamily: "MontserratBold",
                  fontSize: 16,
                  color: HexColor("2056E1"),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton.icon(
              onPressed: _submitChangePhoneOtp, // API'ye OTP kodunu gönder
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor(buttonColor1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              icon: const Icon(Icons.send, color: Colors.white), // İkon eklendi
              label: const Text(
                "Devam et",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
