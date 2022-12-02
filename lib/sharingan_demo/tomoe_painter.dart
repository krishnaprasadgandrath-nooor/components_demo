import 'package:flutter/material.dart';

class TomoePainter extends CustomPainter {
  final Paint tomoePaint;
  TomoePainter({
    required this.tomoePaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset rectCenter = Offset(size.width / 2, size.height / 2);
    double minSide = size.width < size.height ? size.width : size.height;
    drawTomoe(canvas, minSide, rectCenter, tomoePaint); // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void drawTomoe(Canvas canvas, double minSide, Offset offset, Paint paint) {
    double height = minSide;
    double width = minSide * 2;
    double radius = minSide / 2;
    Offset center = offset;
    Offset circleOffset = Offset(center.dx - radius, center.dy);
    Offset offset4 = Offset(center.dx + radius, center.dy);
    Offset offset5 = Offset(circleOffset.dx, circleOffset.dy + radius);
    // paint..style = PaintingStyle.stroke;
    // canvas.drawRect(Rect.fromCenter(center: center, width: width, height: height), paint);
    canvas.drawCircle(circleOffset, radius, paint);
    Path path = Path();

    ///First cubic point
    double curveEffect = radius / 2;
    Offset middleOffset = Offset(offset4.dx - curveEffect, center.dy - curveEffect);
    path.moveTo(center.dx, center.dy);

    path.quadraticBezierTo(
      (offset.dx + center.dx) * 0.2,
      (center.dy + radius) * 0.8,
      offset4.dx,
      offset4.dy,
    );

    path.quadraticBezierTo(
      (offset4.dx + center.dx + radius) * 0.6,
      (center.dy + radius / 2),
      offset5.dx,
      offset5.dy,
    );

    // path.lineTo(circleOffset.dx, circleOffset.dy + radius);
    path.close();

    canvas.drawPath(path, paint);
    // path.relativeQuadraticBezierTo(center.dx, center.dy, offset4.dx, offset4.dy);
    // path.relativeQuadraticBezierTo(center.dx, center.dy, center.dx + minSide, center.dy - radius);
  }
}
