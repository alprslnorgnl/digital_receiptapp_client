import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/colors.dart';
import '../../services/ocr_service.dart';
import '../../services/qr_service.dart';
import '../components/appbar.dart';
import '../components/navigate_bar.dart';
import '../components/ocr_result_dialog.dart';

class AddReceipt extends StatefulWidget {
  const AddReceipt({super.key});

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  final OcrService _ocrService = OcrService();
  final QrService _qrService = QrService();
  Map<String, dynamic>? _ocrData;

  void _selectOcr() async {
    final data = await _ocrService.pickImageAndExtractText();
    if (data != null) {
      setState(() {
        _ocrData = data;
      });
      _showOcrResultDialog(data);
    }
  }

  void _showOcrResultDialog(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OcrResultDialog(
          data: data,
          onSave: _saveReceipt,
        );
      },
    );
  }

  void _saveReceipt() async {
    if (_ocrData != null) {
      final success = await _ocrService.saveReceipt(_ocrData!);
      Navigator.of(context).pop(); // Close the dialog after save
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Receipt saved successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save receipt')));
      }
    }
  }

  void _selectQrCode() async {
    await _qrService.scanQrCode(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Appbar(appbarText: "FİŞ EKLEME"),
        Text(
          "Lütfen fişinizi hangi yöntem ile eklemek istediğinizi seçiniz",
          style: TextStyle(fontSize: 18, color: HexColor(fontColor3)),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        SizedBox(
          width: 302,
          height: 80,
          child: GestureDetector(
            onTap: _selectOcr,
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("B8C0E8"),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 120, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.document_scanner_rounded, size: 50),
                    Text(
                      "OCR",
                      style: TextStyle(
                        fontFamily: "MontserratRegular",
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 302,
          height: 80,
          child: GestureDetector(
            onTap: _selectQrCode,
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("B8C0E8"),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 90, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.qr_code_scanner, size: 50),
                    Text(
                      "QR CODE",
                      style: TextStyle(
                        fontFamily: "MontserratRegular",
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Spacer(
          flex: 2,
        ),
      ]),
      bottomNavigationBar: const NavigateBar(page: 2),
    );
  }
}
