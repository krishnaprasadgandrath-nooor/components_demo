import 'package:flutter/material.dart';

class SharinganPainter extends CustomPainter {
  Paint redPaint = Paint()..color = Colors.red;
  Paint blackPaint = Paint()..color = Colors.black;
  Paint blackStroked = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;
  @override
  void paint(Canvas canvas, Size size) {
    double minSide = size.height > size.width ? size.width : size.height;
    double outerRadius = minSide / 2;
    double innerRadius = outerRadius * (3 / 4);
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, outerRadius, blackStroked);

    ///Bg Circle
    canvas.drawCircle(center, outerRadius, redPaint);

    ///Black Circle
    canvas.drawCircle(center, innerRadius, blackStroked);

    canvas.drawCircle(center, innerRadius / 2, blackPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
