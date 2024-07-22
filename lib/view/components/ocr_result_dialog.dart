import 'package:flutter/material.dart';

class OcrResultDialog extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onSave;

  const OcrResultDialog({
    Key? key,
    required this.data,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buildProductList(List<dynamic> products) {
      return products.map((product) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Name: ${product['productName']}",
                  style: const TextStyle(fontSize: 14)),
              Text("Product Piece: ${product['productPiece']}",
                  style: const TextStyle(fontSize: 14)),
              Text("KDV Rate: ${product['kdvRate']}",
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
        );
      }).toList();
    }

    return AlertDialog(
      title: const Text('OCR Data'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Market Name: ${data['marketName']}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Market Branch: ${data['marketBranch']}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("DateTime: ${data['dateTime']}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Total Quantity: ${data['totalQuantity']}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Products:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildProductList(data['products']),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
