import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';

class Success extends StatelessWidget {
  const Success({super.key, required this.text1, required this.text2});

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("33B338"),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset("lib/assets/images/success.png"),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "BAŞARILI!",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 36.0,
                  color: HexColor(fontColor2),
                  letterSpacing: 15.0,
                ),
              ),
            ),
            const Spacer(),
            Text(
              text1,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 18.0,
                color: HexColor(fontColor2),
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                text2,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18.0,
                  color: HexColor(fontColor2),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
