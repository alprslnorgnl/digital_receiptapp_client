import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import 'check_receipt_piece.dart';
import 'google_api.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';

class GoogleWith extends StatefulWidget {
  const GoogleWith({super.key});

  @override
  State<GoogleWith> createState() => _GoogleWithState();
}

class _GoogleWithState extends State<GoogleWith> {
  Future<void> googleLogin() async {
    final user = await GoogleApi.login();

    if (user != null) {
      final auth = await user.authentication;

      var response = await http.post(
        Uri.parse('http://10.0.2.2:5109/api/User/googleLogin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          'AccessToken': auth.accessToken,
        }),
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print(responseBody);
        var token = responseBody['token'];
        print('Google ile giriş yapan kullanıcı Token: $token');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CheckReceiptPiece()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Sign-In failed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-In failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //Ekran width değeri değişkende tutulur
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth,
      child: ElevatedButton(
          onPressed: googleLogin,
          style:
              ElevatedButton.styleFrom(backgroundColor: HexColor(fontColor2)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: SvgPicture.asset(
                    "lib/assets/images/ic_google.svg",
                    colorFilter:
                        ColorFilter.mode(HexColor(fontColor1), BlendMode.srcIn),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text("Google ile giriş yap"),
              ),
            ],
          )),
    );
  }
}
