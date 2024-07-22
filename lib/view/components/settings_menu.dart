import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key, required this.icon, required this.heading});

  final IconData icon;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(icon, size: 30),
          ),
          Text(
            heading,
            style: const TextStyle(fontFamily: "Montserrat", fontSize: 20.0),
          )
        ],
      ),
    );
  }
}
