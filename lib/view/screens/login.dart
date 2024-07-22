import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import '../../controller/login_controller.dart';
import '../components/check_receipt_piece.dart';
import '../components/google_with.dart';
import 'change_phone_number.dart';
import 'password_reset_choice.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginController = Logincontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 65.0, left: 30.0, bottom: 30),
            child: Text(
              "Giriş yap",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 36.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              "Tekrardan hoşgeldiniz! Lütfen istenen bilgileri giriniz",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 14.0,
                color: HexColor(fontColor3),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                Text(
                  "Hesabınız yok mu? ",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14.0,
                    color: HexColor(fontColor3),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Signup()));
                  },
                  child: Text(
                    "Hesap oluşturun",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.0,
                      color: HexColor(fontColor4),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //PhoneNumber
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumberController,
                    onChanged: (value) {
                      _loginController.setPhoneNumber(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Telefon Numarası",
                      prefixIcon: const Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  //Password
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      onChanged: (value) {
                        _loginController.setPassword(value);
                      },
                      decoration: InputDecoration(
                        labelText: "Şifreniz",
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
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PasswordResetChoice()));
                      },
                      child: Text(
                        "Şifremi unuttum!",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          color: HexColor(fontColor3),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ChangePhoneNumber()));
                    },
                    child: Text(
                      "Telefon numaramı değiştirdim!",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        color: HexColor(fontColor3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        String? result = _loginController.validateFields();
                        if (result == null) {
                          String? result2 = await _loginController.login();
                          if (result2 != "200") {
                            showSnackBar(context, result2!);
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CheckReceiptPiece(),
                              ),
                            );
                          }
                        } else {
                          showSnackBar(context, result);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(buttonColor1)),
                      child: Text(
                        "Giriş yap",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 18.0,
                          color: HexColor(fontColor2),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: GoogleWith()),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
