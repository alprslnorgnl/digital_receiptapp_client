import 'dart:async';

import 'package:flutter/material.dart';

import '../components/check_receipt_piece.dart';
import '../components/success.dart';

class SuccessPasswordChangeSettings extends StatefulWidget {
  const SuccessPasswordChangeSettings({super.key});

  @override
  State<SuccessPasswordChangeSettings> createState() =>
      _SuccessPasswordChangeSettingsState();
}

class _SuccessPasswordChangeSettingsState
    extends State<SuccessPasswordChangeSettings> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CheckReceiptPiece()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Success(
        text1: "Şifreniz başarılı bir şekilde değiştirilmiştir",
        text2: "Ana sayfaya yönlendiriliyorsunuz...",
      ),
    );
  }
}
