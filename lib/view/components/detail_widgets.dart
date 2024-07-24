import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../model/receipt_model.dart';

Widget buildDetailItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color: HexColor("B8C0E8"),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: ListTile(
        title: Text("$title: $value"),
      ),
    ),
  );
}

Widget buildProductItem(ProductModel product) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Container(
      decoration: BoxDecoration(
        color: HexColor("B8C0E8"),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: ListTile(
        title: Text("Ürün: ${product.productName}"),
        subtitle: Text(
            "Adet: ${product.productPiece}\nKDV Oranı: ${product.kdvRate}"),
      ),
    ),
  );
}
