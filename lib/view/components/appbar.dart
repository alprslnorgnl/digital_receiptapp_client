import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key, required this.appbarText});

  final String appbarText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              appbarText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: "MontserratRegular",
                  fontSize: 20.0,
                  letterSpacing: 10.0),
            ),
          ),
        ),
      ),
    );
  }
}
