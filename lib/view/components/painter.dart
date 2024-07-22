import 'package:flutter/material.dart';

class ReceiptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(-166, 0)
      ..lineTo(166, 0)
      ..lineTo(166, 550)
      ..lineTo(110.7, 500)
      ..lineTo(55.4, 550)
      ..lineTo(0.1, 500)
      ..lineTo(-55.2, 550)
      ..lineTo(-110.5, 500)
      ..lineTo(-166, 550)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
