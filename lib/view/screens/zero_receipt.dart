import 'package:flutter/material.dart';
import 'package:receipt_app/view/components/navigateBar.dart';

import '../components/appbar.dart';
import 'addReceipt.dart';

class ZeroReceipt extends StatefulWidget {
  const ZeroReceipt({super.key});

  @override
  State<ZeroReceipt> createState() => _ZeroReceiptState();
}

class _ZeroReceiptState extends State<ZeroReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Appbar(appbarText: "FİŞ BİLGİLERİ"),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Hesabınızda şu ana kadar fiş kaydı bulunmamıştır.",
            style: TextStyle(
              fontFamily: "MontserratRegular",
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddReceipt()),
            );
          },
          child: const Icon(
            Icons.add_circle_outline,
            size: 30,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "İkonuna tıklayarak \"Fiş Ekleme\" sekmesine geçiş yapabilirsiniz",
            style: TextStyle(
              fontFamily: "MontserratRegular",
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(
          flex: 2,
        )
      ]),
      bottomNavigationBar: const NavigateBar(page: 1),
    );
  }
}
