import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'package:http/http.dart' as http;

import '../components/otp_input.dart';
import 'password_reset_email.dart';
import 'password_reset_last.dart';

class PasswordResetEmailOtp extends StatefulWidget {
  const PasswordResetEmailOtp({super.key, required this.email});

  final String email;

  @override
  State<PasswordResetEmailOtp> createState() => _PasswordResetEmailOtpState();
}

class _PasswordResetEmailOtpState extends State<PasswordResetEmailOtp> {
  String _otpCode = '';

  void _onOtpCompleted(String otp) {
    setState(() {
      _otpCode = otp;
    });
  }

  Future<void> _submitPasswordResetEmailOtp() async {
    final url = Uri.parse(
        'http://10.0.2.2:5109/api/User/passwordResetOtpV'); // API endpoint URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'Email': widget.email,
        'Code': _otpCode,
        'Phone': "",
      }),
    );

    if (response.statusCode == 200) {
      print('OTP doğrulandı');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PasswordResetLast(
                emailOrPhone: widget.email,
              )));
    } else {
      var responseBody = json.decode(response.body);
      var message = responseBody['message'];
      print('Hata mesajı: $message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                "E-mail doğrulama",
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
                "${widget.email} adresine gönderdiğimiz 6 haneli kodu giriniz",
                style: const TextStyle(
                    fontFamily: "MontserratLight", fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            OtpInput(onCompleted: _onOtpCompleted),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PasswordResetEmail()));
                },
                child: Text(
                  "Doğru mail adresini girdiğine emin misiniz?",
                  style: TextStyle(
                    fontFamily: "MontserratBold",
                    fontSize: 16,
                    color: HexColor("2056E1"),
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed:
                    _submitPasswordResetEmailOtp, // API'ye OTP kodunu gönder
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor(buttonColor1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                icon:
                    const Icon(Icons.send, color: Colors.white), // İkon eklendi
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
      ),
    );
  }
}
