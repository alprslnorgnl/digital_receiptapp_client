import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:receipt_app/view/components/appbarWithArrow.dart';
import 'package:receipt_app/view/screens/changePhoneSettingsOtp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../constants/colors.dart';

class ChangePhoneSettings extends StatefulWidget {
  const ChangePhoneSettings({super.key});

  @override
  State<ChangePhoneSettings> createState() => _ChangePhoneSettingsState();
}

class _ChangePhoneSettingsState extends State<ChangePhoneSettings> {
  final _oldPhoneController = TextEditingController();
  final _newPhoneController = TextEditingController();

  void _changePhone() async {
    final String newPhone = _newPhoneController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final url = Uri.parse('http://35.202.100.38:8080/api/BaseUser/changePhone');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'newPhone': newPhone,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Phone Number changed successfully');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChangePhoneSettingsOtp(
              oldPhone: _oldPhoneController.text,
              newPhone: _newPhoneController.text)));
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
                appbarText: "NUMARA DEĞİŞTİR", detailPage: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "NUMARANI DEĞİŞTİR",
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
                        "Numaranızı değiştirmek için aşağıdaki kutucuğa yeni numaranızı giriniz",
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
                      keyboardType: TextInputType.phone,
                      controller: _oldPhoneController,
                      decoration: InputDecoration(
                        labelText: "Eski telefon numaranız",
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
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _newPhoneController,
                    decoration: InputDecoration(
                      labelText: "Yeni telefon numaranız",
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
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                      onPressed: _changePhone,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(buttonColor1)),
                      child: Text(
                        "Kod gönder",
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
