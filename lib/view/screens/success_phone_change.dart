import 'dart:async';

import 'package:flutter/material.dart';
import 'package:receipt_app/view/screens/login.dart';

import '../components/success.dart';

class SuccessPhoneChange extends StatefulWidget {
  const SuccessPhoneChange({super.key});

  @override
  State<SuccessPhoneChange> createState() => _SuccessPhoneChangeState();
}

class _SuccessPhoneChangeState extends State<SuccessPhoneChange> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Login()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Success(
        text1: "Telefon numaranız başarılı bir şekilde değiştirilmiştir",
        text2: "Giriş sayfasına yönlendiriliyorsunuz...",
      ),
    );
  }
}
