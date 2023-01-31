import 'dart:ui';

import 'package:flutter/material.dart';

class TriangleArtPainter extends CustomPainter {
  Color color;
  int pointNum;
  TriangleArtPainter({this.color = Colors.black, this.pointNum = 10});

  @override
  void paint(Canvas canvas, Size size) {
    Offset topCenter = Offset(size.width / 2, 0);
    Offset bottomLeft = Offset(0, size.height);
    Offset bottomRight = Offset(size.width, size.height);
    List<Offset> leftSidePoints = [];

    double right_diff_X = topCenter.dx - bottomLeft.dx;
    double right_diff_Y = bottomLeft.dy - topCenter.dy;

    double right_interval_X = right_diff_X / (pointNum + 1);
    double right_interval_Y = right_diff_Y / (pointNum + 1);

    List<Offset> rightPointsList = [];
    for (int i = 1; i <= pointNum; i++) {
      rightPointsList.add(Offset(topCenter.dx + right_interval_X * i, topCenter.dy + right_interval_Y * i));
    }

    double bottom_diff_X = bottomRight.dx - bottomLeft.dx;
    double bottom_diff_Y = bottomRight.dy - bottomLeft.dy;

    double bottom_interval_X = bottom_diff_X / (pointNum + 1);
    double bottom_interval_Y = bottom_diff_Y / (pointNum + 1);

    List<Offset> bottomPointsList = [];
    for (int i = 1; i <= pointNum; i++) {
      bottomPointsList.add(Offset(bottomRight.dx - bottom_interval_X * i, bottomRight.dy + bottom_interval_Y * i));
    }

    double left_diff_X = topCenter.dx - bottomLeft.dx;
    double left_diff_Y = bottomLeft.dy - topCenter.dy;

    double left_interval_X = left_diff_X / (pointNum + 1);
    double left_interval_Y = left_diff_Y / (pointNum + 1);

    List<Offset> leftPointsList = [];
    for (int i = 1; i <= pointNum; i++) {
      leftPointsList.add(Offset(bottomLeft.dx + left_interval_X * i, bottomLeft.dy - left_interval_Y * i));
    }

    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;
    Path path = Path();

    path.moveTo(topCenter.dx, topCenter.dy);
    path.lineTo(bottomRight.dx, bottomRight.dy);
    path.lineTo(bottomLeft.dx, bottomLeft.dy);
    path.close();
    canvas.drawPath(path, paint);
    Paint secondaryPaint = Paint();
    secondaryPaint.color = Colors.red;
    secondaryPaint.style = PaintingStyle.stroke;

    // for (var element in rightPointsList) {
    //   canvas.drawCircle(element, 10.0, secondaryPaint);
    // }

    // for (var element in bottomPointsList) {
    //   canvas.drawCircle(element, 10.0, secondaryPaint);
    // }

    // for (var element in leftPointsList) {
    //   canvas.drawCircle(element, 10.0, secondaryPaint);
    // }

    for (var i = 0; i < pointNum; i++) {
      canvas.drawLine(rightPointsList[i], bottomPointsList[i], secondaryPaint);
      canvas.drawLine(bottomPointsList[i], leftPointsList[i], secondaryPaint);
      canvas.drawLine(leftPointsList[i], rightPointsList[i], secondaryPaint);
    }

    // canvas.drawCircle(element, 20.0, whitePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
