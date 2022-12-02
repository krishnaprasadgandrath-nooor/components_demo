import 'package:flutter/material.dart';

class CustomShape extends ShapeBorder {
  final double leftEndDiff;

  CustomShape({this.leftEndDiff = 20});
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.moveTo(rect.left + 20, rect.top + 20);
    path.lineTo(rect.right, rect.top);
    path.lineTo(rect.right, rect.bottom);
    path.lineTo(rect.left + 20, rect.bottom - 20);
    path.close();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.moveTo(rect.left + 20, rect.top + 20);
    path.lineTo(rect.right, rect.top);
    path.lineTo(rect.right, rect.bottom);
    path.lineTo(rect.left + 20, rect.bottom - 20);
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Path path = Path();
    path.moveTo(rect.left + 20, rect.top + 20);
    path.lineTo(rect.right, rect.top);
    path.lineTo(rect.right, rect.bottom);
    path.lineTo(rect.left + 20, rect.bottom - 20);
    path.close();
    canvas.drawPath(path, Paint()..color = Colors.red);
  }

  @override
  ShapeBorder scale(double t) {
    return CustomShape(leftEndDiff: leftEndDiff * t);
  }
}
