import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'package:http/http.dart' as http;

import 'successPasswordChange.dart';

class PasswordResetLast extends StatefulWidget {
  const PasswordResetLast({super.key, required this.emailOrPhone});

  final String emailOrPhone;

  @override
  State<PasswordResetLast> createState() => _PasswordResetLastState();
}

class _PasswordResetLastState extends State<PasswordResetLast> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _newPasswordOnayController = TextEditingController();

  // API Call
  Future<void> _changePassword() async {
    // API çağrısını yapın.
    final url =
        Uri.parse('http://35.202.100.38:8080/api/User/passwordResetLast');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'NewPassword': _newPasswordController.text,
        'NewPasswordConfirm': _newPasswordOnayController.text,
        'EmailOrPhone': widget.emailOrPhone,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SuccessPasswordChange()));
    } else {
      print('change password failed: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Şifreni mi unuttun?",
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
              "Endişelenme!",
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: TextFormField(
                      controller: _newPasswordOnayController,
                      decoration: InputDecoration(
                        labelText: "Yeni şifrenizi tekrar giriniz",
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
                  ElevatedButton(
                    onPressed: _changePassword,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor(buttonColor1)),
                    child: Text(
                      "Devam et",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20.0,
                        color: HexColor(fontColor2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
