import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import '../../controller/signup_controller.dart';
import '../components/google_with.dart';
import 'create_account_otp.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signupController = SignupController();
  bool isChecked = false;
  String data = "";

  //.txt dosyasından veriyi almak için gerekli fonksiyon
  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/kvkk.txt');

    setState(() {
      data = responseText;
    });
  }

  //kvkk metnini göstermek için gerekli fonksiyon
  void _showKVKK(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('KVKK Aydınlatma Metni'),
          content: SingleChildScrollView(
              child: Text(
            data,
            textAlign: TextAlign.justify,
          )),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 65.0, left: 30.0, bottom: 30),
              child: Text(
                "Hesap oluştur",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 36.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Hoşgeldiniz! Lütfen istenen bilgileri giriniz",
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
                    "Zaten hesabınız var mı? ",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.0,
                      color: HexColor(fontColor3),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                    child: Text(
                      "Giriş yapın",
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
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        _signupController.setPhoneNumber(value);
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
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        onChanged: (value) {
                          _signupController.setPassword(value);
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
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                              _signupController.setCheckboxValue(value);
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {
                            _showKVKK(context);
                          },
                          child: Text(
                            "KVKK metnini",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 14.0,
                              color: HexColor(fontColor4),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          " okudum, onaylıyorum",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 14.0,
                            color: HexColor(fontColor3),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          String? result = _signupController.validateFields();
                          if (result == null) {
                            String? result2 = await _signupController.signup();
                            if (result2 != "200") {
                              showSnackBar(context, result2!);
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreateAccountOtp(
                                    phone: _phoneNumberController.text,
                                    password: _passwordController.text,
                                  ),
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
                          "Kayıt ol",
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
