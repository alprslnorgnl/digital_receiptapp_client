import 'dart:async';

import 'package:flutter/material.dart';

import '../components/success.dart';
import 'login.dart';

class SuccessPasswordChange extends StatefulWidget {
  const SuccessPasswordChange({super.key});

  @override
  State<SuccessPasswordChange> createState() => _SuccessPasswordChangeState();
}

class _SuccessPasswordChangeState extends State<SuccessPasswordChange> {
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
    return const SafeArea(
      child: Scaffold(
        body: Success(
          text1: "Şifreniz başarılı bir şekilde değiştirilmiştir",
          text2: "Giriş sayfasına yönlendiriliyorsunuz...",
        ),
      ),
    );
  }
}
