//Buradaki işlem basitçe şudur:
//kullanıcıya uygulama ilk açıldığında göreceği hoşgeldin sayfası sunulur
//signup sayfasına yönlendirilecek bir buton bulunmaktadır.

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/colors.dart';
import 'signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    //Ekran width değeri değişkende tutulur
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 65.0),
            child: Text(
              "Hoşgeldiniz!",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 36.0,
              ),
            ),
          ),
          const Spacer(),
          Image.asset("lib/assets/images/logo.png"),
          const Spacer(),
          Text(
            "Yaşamınızı kolaylaştırın, \nalışverişi dijitalleştirin",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14.0,
              color: HexColor(fontColor3),
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: SizedBox(
              width: screenWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Signup()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: HexColor(buttonColor1)),
                child: Text(
                  "Başlayalım",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 18.0,
                    color: HexColor(fontColor2),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 3,
          )
        ],
      ),
    );
  }
}
