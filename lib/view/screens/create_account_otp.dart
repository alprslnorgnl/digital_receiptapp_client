import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'package:http/http.dart' as http;

import '../components/otp_input.dart';
import 'success_create_account.dart';

class CreateAccountOtp extends StatefulWidget {
  const CreateAccountOtp(
      {super.key, required this.phone, required this.password});

  final String phone;
  final String password;

  @override
  State<CreateAccountOtp> createState() => _CreateAccountOtpState();
}

class _CreateAccountOtpState extends State<CreateAccountOtp> {
  String _otpCode = '';

  void _onOtpCompleted(String otp) {
    setState(() {
      _otpCode = otp;
    });
    print("onOtpCompleted fonksiyonu içerisi $_otpCode");
  }

  Future<void> _submitCreateAccountOtp() async {
    print("submit fonksiyonu içerisi: $_otpCode");
    final url =
        Uri.parse('http://35.202.100.38:8080/api/User/createAccountOtpV');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'OtpCode': _otpCode,
        'PhoneNumber': widget.phone,
        'Password': widget.password,
      }),
    );

    if (response.statusCode == 200) {
      print('OTP doğrulandı');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SuccessCreateAccount()));
    } else {
      final responseBody = jsonDecode(response.body);
      showSnackBar(context, responseBody['message']);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              "${widget.phone} numarasına gönderdiğimiz 6 haneli kodu giriniz",
              style: const TextStyle(
                  fontFamily: "MontserratLight", fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          OtpInput(onCompleted: _onOtpCompleted),
          const Spacer(),
          Center(
            child: ElevatedButton.icon(
              onPressed: _submitCreateAccountOtp, // API'ye OTP kodunu gönder
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
