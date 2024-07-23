import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'change_phone_number_otp.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({super.key});

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  final _formKey = GlobalKey<FormState>();
  final _oldPhoneNumberController = TextEditingController();
  final _newPhoneNumberController = TextEditingController();

  // API Call
  Future<void> _changePhone(String oldPhone, String newPhone) async {
    // API çağrısını yapın.
    final url = Uri.parse('http://10.0.2.2:5109/api/User/changePhone');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'oldPhoneNumber': oldPhone,
        'newPhoneNumber': newPhone,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChangePhoneNumberOtp(
              oldPhone: _oldPhoneNumberController.text,
              newPhone: _newPhoneNumberController.text)));
    } else {
      print('change phone number failed: ${response.body}');
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
                "Telefon numaranı mı değiştirdin?",
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
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _oldPhoneNumberController,
                    decoration: InputDecoration(
                      labelText: "Eski Telefon Numaranız",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _newPhoneNumberController,
                      decoration: InputDecoration(
                        labelText: "Yeni Telefon Numaranız",
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
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _changePhone(_oldPhoneNumberController.text,
                          _newPhoneNumberController.text);
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
                ]),
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
      ),
    );
  }
}
