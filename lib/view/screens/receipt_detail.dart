import 'package:flutter/material.dart';
import 'package:receipt_app/model/ReceiptModel.dart';
import 'package:receipt_app/view/components/appbarWithArrow.dart';
import 'package:receipt_app/view/components/icons.dart';
import 'package:receipt_app/view/components/painter.dart';
import 'package:receipt_app/view/components/detail_widgets.dart';
import 'package:share/share.dart';
import '../../services/DateTimeUtil.dart';
import '../../services/ReceiptService.dart';
import 'SeeReceiptData.dart'; // SeeReceiptData sayfasını import ediyoruz

class ReceiptDetail extends StatefulWidget {
  const ReceiptDetail(
      {super.key,
      required this.date,
      required this.receipt,
      required this.allReceipts});

  final String date;
  final ReceiptModel receipt;
  final List<ReceiptModel> allReceipts;

  @override
  State<ReceiptDetail> createState() => _ReceiptDetailState();
}

class _ReceiptDetailState extends State<ReceiptDetail> {
  late ReceiptModel receipt = widget.receipt;
  late List<ReceiptModel> allReceipts = widget.allReceipts;

  void _toggleFavorite() async {
    final success = await ReceiptService().toggleFavorite(receipt.id);
    if (success) {
      setState(() {
        receipt = receipt.copyWith(favorite: !receipt.favorite);
      });
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Uyarı"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Silmek istiyor musunuz?"),
          content: const Text("Bu fişi silmek istediğinizden emin misiniz?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Hayır"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final success =
                    await ReceiptService().deleteReceipt(receipt.id);
                if (success) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SeeReceiptData(),
                      ),
                    );
                  });
                } else {
                  _showAlertDialog("Fiş silinemedi. Lütfen tekrar deneyiniz.");
                }
              },
              child: const Text("Evet"),
            ),
          ],
        );
      },
    );
  }

  void _shareReceipt() {
    final receiptDetails = """
    Market Name: ${receipt.marketName}
    Market Branch: ${receipt.marketBranch}
    Date: ${formatDateTime(receipt.dateTime)}
    Total Quantity: ${receipt.totalQuantity}
    Products:
    ${receipt.products.map((product) => "Product: ${product.productName}, Quantity: ${product.productPiece}, KDV Rate: ${product.kdvRate}").join("\n")}
    """;

    Share.share(receiptDetails);
  }

  void _goToPreviousReceipt() {
    final currentIndex = allReceipts.indexOf(receipt);
    if (currentIndex > 0) {
      final previousReceipt = allReceipts[currentIndex - 1];
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ReceiptDetail(
            date: formatDate(previousReceipt.dateTime),
            receipt: previousReceipt,
            allReceipts: allReceipts,
          ),
        ),
      );
    } else {
      _showAlertDialog("En baştaki fiştesiniz.");
    }
  }

  void _goToNextReceipt() {
    final currentIndex = allReceipts.indexOf(receipt);
    if (currentIndex < allReceipts.length - 1) {
      final nextReceipt = allReceipts[currentIndex + 1];
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ReceiptDetail(
            date: formatDate(nextReceipt.dateTime),
            receipt: nextReceipt,
            allReceipts: allReceipts,
          ),
        ),
      );
    } else {
      _showAlertDialog("En sondaki fiştesiniz.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppbarWithArrow(
            appbarText: widget.date,
            detailPage: true,
          ),
          CustomPaint(
            painter: ReceiptPainter(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 20, 70, 15),
            child: RowIcons(
              receipt: receipt,
              onFavoriteToggle: _toggleFavorite,
              onDelete: _showDeleteDialog, // Delete fonksiyonunu ekledik
              onShare: _shareReceipt, // Share fonksiyonunu ekledik
            ),
          ),
          SizedBox(
            height: 360,
            child: Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 55.0, vertical: 10.0),
                children: [
                  buildDetailItem("Market Name", receipt.marketName),
                  buildDetailItem("Market Branch", receipt.marketBranch),
                  buildDetailItem("Date", formatDateTime(receipt.dateTime)),
                  buildDetailItem(
                      "Total Quantity", receipt.totalQuantity.toString()),
                  buildDetailItem("Favorite", receipt.favorite ? "Yes" : "No"),
                  const SizedBox(height: 20), // Boşluk eklemek için
                  const Text(
                    "Products:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...receipt.products
                      .map((product) => buildProductItem(product)),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left, size: 36.0),
                  onPressed: _goToPreviousReceipt,
                ),
                const SizedBox(width: 50),
                IconButton(
                  icon: const Icon(Icons.arrow_right, size: 36.0),
                  onPressed: _goToNextReceipt,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
