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
    // List<Offset> leftSidePoints = [];

    double rightDiffX = topCenter.dx - bottomLeft.dx;
    double rightDiffY = bottomLeft.dy - topCenter.dy;

    double rightIntervalX = rightDiffX / (pointNum + 1);
    double rightIntervalY = rightDiffY / (pointNum + 1);

    List<Offset> rightPointsList = [];
    for (int i = 1; i <= pointNum; i++) {
      rightPointsList.add(Offset(topCenter.dx + rightIntervalX * i, topCenter.dy + rightIntervalY * i));
    }

    double bottomDiffX = bottomRight.dx - bottomLeft.dx;
    double bottomDiffY = bottomRight.dy - bottomLeft.dy;

    double bottomIntervalX = bottomDiffX / (pointNum + 1);
    double bottomIntervalY = bottomDiffY / (pointNum + 1);

    List<Offset> bottomPointsList = [];
    for (int i = 1; i <= pointNum; i++) {
      bottomPointsList.add(Offset(bottomRight.dx - bottomIntervalX * i, bottomRight.dy + bottomIntervalY * i));
    }

    double leftDiffX = topCenter.dx - bottomLeft.dx;
    double leftDiffY = bottomLeft.dy - topCenter.dy;

    double leftIntervalX = leftDiffX / (pointNum + 1);
    double leftIntervalY = leftDiffY / (pointNum + 1);

    List<Offset> leftPointsList = [];
    for (int i = 1; i <= pointNum; i++) {
      leftPointsList.add(Offset(bottomLeft.dx + leftIntervalX * i, bottomLeft.dy - leftIntervalY * i));
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
