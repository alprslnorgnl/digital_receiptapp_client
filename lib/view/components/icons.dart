import 'package:flutter/material.dart';
import '../../model/receipt_model.dart';

class RowIcons extends StatefulWidget {
  const RowIcons({
    super.key,
    required this.receipt,
    required this.onFavoriteToggle,
    required this.onDelete,
    required this.onShare,
  });

  final ReceiptModel receipt;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  @override
  State<RowIcons> createState() => _RowIconsState();
}

class _RowIconsState extends State<RowIcons> {
  late IconData icon =
      widget.receipt.favorite ? Icons.favorite : Icons.favorite_border;

  late Color iconColor = widget.receipt.favorite ? Colors.red : Colors.black;

  @override
  void didUpdateWidget(RowIcons oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.receipt.favorite != oldWidget.receipt.favorite) {
      setState(() {
        icon = widget.receipt.favorite ? Icons.favorite : Icons.favorite_border;
        iconColor = widget.receipt.favorite ? Colors.red : Colors.black;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(icon),
          color: iconColor,
          onPressed: widget.onFavoriteToggle,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: widget.onDelete,
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: widget.onShare,
        ),
      ],
    );
  }
}
