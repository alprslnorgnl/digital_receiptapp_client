import 'dart:async';

import 'package:flutter/material.dart';

import '../components/check_receipt_piece.dart';
import '../components/success.dart';

class SuccessPhoneChangeSettings extends StatefulWidget {
  const SuccessPhoneChangeSettings({super.key});

  @override
  State<SuccessPhoneChangeSettings> createState() =>
      _SuccessPhoneChangeSettingsState();
}

class _SuccessPhoneChangeSettingsState
    extends State<SuccessPhoneChangeSettings> {
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
        text1: "Telefon numaranız başarılı bir şekilde değiştirilmiştir",
        text2: "Ana sayfasına yönlendiriliyorsunuz...",
      ),
    );
  }
}
