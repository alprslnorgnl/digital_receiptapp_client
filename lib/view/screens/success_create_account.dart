import 'dart:async';

import 'package:flutter/material.dart';

import '../components/success.dart';
import 'login.dart';

class SuccessCreateAccount extends StatefulWidget {
  const SuccessCreateAccount({super.key});

  @override
  State<SuccessCreateAccount> createState() => _SuccessCreateAccountState();
}

class _SuccessCreateAccountState extends State<SuccessCreateAccount> {
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
          text1: "Hesabınız başarılı bir şekilde oluşturulmuştur",
          text2: "Giriş sayfasına yönlendiriliyorsunuz...",
        ),
      ),
    );
  }
}
