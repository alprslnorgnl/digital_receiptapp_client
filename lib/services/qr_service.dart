import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QrService {
  final String _addReceiptApiUrl =
      'http://35.202.100.38:8080/api/Receipt/addReceipt';

  Future<void> scanQrCode(BuildContext context) async {
    final qrKey = GlobalKey(debugLabel: 'QR');
    String scannedData = '';

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Scan QR Code')),
          body: QRView(
            key: qrKey,
            onQRViewCreated: (QRViewController controller) {
              controller.scannedDataStream.listen((scanData) async {
                scannedData = scanData.code!;
                controller.dispose();
                Navigator.pop(context);
              });
            },
          ),
        ),
      ),
    );

    if (scannedData.isNotEmpty) {
      final receiptData = jsonDecode(scannedData);
      await saveReceipt(receiptData);
    }
  }

  Future<bool> saveReceipt(Map<String, dynamic> receiptData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token') ?? '';

    final response = await http.post(
      Uri.parse(_addReceiptApiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(receiptData),
    );

    return response.statusCode == 200;
  }
}
