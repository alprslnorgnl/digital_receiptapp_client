import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

import 'passwordResetEmailOtp.dart';

class PasswordResetEmail extends StatefulWidget {
  const PasswordResetEmail({super.key});

  @override
  State<PasswordResetEmail> createState() => _PasswordResetEmailState();
}

class _PasswordResetEmailState extends State<PasswordResetEmail> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // API Call
  Future<void> _passwordResetEmail(String email) async {
    // API çağrısını yapın.
    final url = Uri.parse('http://35.202.100.38:8080/api/User/passwordReset');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Email': email,
        'Phone': "",
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PasswordResetEmailOtp(
                email: _emailController.text,
              )));
    } else {
      var responseBody = json.decode(response.body);
      var message = responseBody['message'];
      print('Hata mesajı: $message');
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
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "E-mail adresinizi giriniz",
                      prefixIcon: const Icon(Icons.email),
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
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () async {
                        await _passwordResetEmail(_emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(buttonColor1)),
                      child: Text(
                        "Kod gönder",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 20.0,
                          color: HexColor(fontColor2),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Problem yok mu? ",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  color: HexColor(fontColor3),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Text(
                  "Giriş yap",
                  style: TextStyle(
                    fontFamily: "MontserratExtraBold",
                    fontSize: 18,
                    color: HexColor(fontColor1),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
