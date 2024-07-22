import 'package:flutter/material.dart';

import '../components/appbar_with_arrow.dart';
import '../components/check_receipt_piece.dart';

class ZeroFavorite extends StatefulWidget {
  const ZeroFavorite({super.key});

  @override
  State<ZeroFavorite> createState() => _ZeroFavoriteState();
}

class _ZeroFavoriteState extends State<ZeroFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const AppbarWithArrow(
          appbarText: "FAVORİLER",
          detailPage: true,
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            "Şu ana kadar favorilere eklediğiniz fiş bilgisi bulunamamıştır",
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
              MaterialPageRoute(
                  builder: (context) => const CheckReceiptPiece()),
            );
          },
          child: const Icon(
            Icons.receipt_outlined,
            size: 30,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "İkonuna tıklayarak \"Fiş Bilgileri\" sekmesine geçiş yapabilirsiniz",
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
    );
  }
}
