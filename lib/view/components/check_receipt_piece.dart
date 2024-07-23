import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login.dart';
import '../screens/see_receipt_data.dart';
import '../screens/zero_receipt.dart';

class CheckReceiptPiece extends StatefulWidget {
  const CheckReceiptPiece({super.key});

  @override
  State<CheckReceiptPiece> createState() => _CheckReceiptPieceState();
}

class _CheckReceiptPieceState extends State<CheckReceiptPiece> {
  @override
  void initState() {
    super.initState();
    _fetchReceiptCount();
  }

  Future<void> _fetchReceiptCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    if (token.isEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:5109/api/Receipt/count'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final receiptCount = data['receiptCount'];
      if (receiptCount == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ZeroReceipt()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SeeReceiptData()),
        );
      }
    } else {
      // Hata durumunda işlem yap
      print('Fiş sayısı alınırken hata oluştu: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
