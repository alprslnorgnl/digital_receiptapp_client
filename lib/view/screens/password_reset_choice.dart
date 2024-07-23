import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'login.dart';
import 'password_reset_email.dart';
import 'password_reset_phone.dart';

class PasswordResetChoice extends StatelessWidget {
  const PasswordResetChoice({super.key});

  @override
  Widget build(BuildContext context) {
    //Ekran width değeri değişkende tutulur
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
            const Spacer(flex: 3),
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
            const Spacer(flex: 1),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Öncelikle şifreni hangi metot ile \nsıfırlamak istediğini seçmelisin",
                style: TextStyle(
                  fontFamily: "MontserratLight",
                  fontSize: 16.0,
                  color: HexColor(fontColor1),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PasswordResetEmail()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor(buttonColor1)),
                  child: Text(
                    "E-mail",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 20.0,
                      color: HexColor(fontColor2),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: screenWidth,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const PasswordResetPhone()));
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(
                            color: HexColor(buttonColor1), width: 2)),
                    child: Text(
                      "Telefon numarası",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 20.0,
                        color: HexColor(fontColor1),
                      ),
                    )),
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
