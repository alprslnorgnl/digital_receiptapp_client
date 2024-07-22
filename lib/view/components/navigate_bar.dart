import 'package:flutter/material.dart';
import 'package:receipt_app/view/components/checkReceiptPiece.dart';

import '../screens/ReceiptAnalysis.dart';
import '../screens/addReceipt.dart';
import '../screens/settings.dart';

class NavigateBar extends StatefulWidget {
  const NavigateBar({super.key, required this.page});

  final int page;

  @override
  State<NavigateBar> createState() => _NavigateBarState();
}

class _NavigateBarState extends State<NavigateBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (widget.page != 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CheckReceiptPiece(),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 69,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.page == 1 ? Colors.black : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(
                  Icons.receipt_outlined,
                  size: 30,
                  color: widget.page == 1 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.page != 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddReceipt(),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 69,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                    color: widget.page == 2 ? Colors.black : Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                  color: widget.page == 2 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.page != 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReceiptAnalysis(),
                  ),
                );
              }
            },
            child: SizedBox(
              width: 69,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.page == 3 ? Colors.black : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(
                  Icons.analytics_outlined,
                  size: 30,
                  color: widget.page == 3 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (widget.page != 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              }
            },
            child: SizedBox(
              width: 69,
              height: 54,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.page == 4 ? Colors.black : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Icon(
                  Icons.settings_outlined,
                  size: 30,
                  color: widget.page == 4 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
