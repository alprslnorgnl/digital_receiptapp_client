import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:receipt_app/constants/colors.dart';

class SubMenu extends StatelessWidget {
  const SubMenu({super.key, required this.text, required this.bildirim});

  final String text;
  final bool bildirim;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Text(
              text,
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 18,
                  color: HexColor(fontColor3)),
            ),
          ),
          Icon(
            bildirim ? Icons.toggle_off_outlined : Icons.arrow_forward,
            color: HexColor(fontColor3),
          )
        ],
      ),
    );
  }
}
