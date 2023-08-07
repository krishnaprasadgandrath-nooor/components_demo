import 'dart:math';

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

const maxVicinityLimit = 1.0;

extension DoubleExt on double {
  bool inVicinity(double other, double maxDistance) {
    if ((other.toInt() - toInt()).abs() < maxDistance) return true;
    return false;
  }

  bool inDefVicinity(double other) {
    if ((other.toInt() - toInt()).abs() <= maxVicinityLimit) return true;
    return false;
  }
}

double calculateAngle(Offset a, Offset b, Offset c) {
  final ab = Offset(b.dx - a.dx, b.dy - a.dy);
  final bc = Offset(c.dx - b.dx, c.dy - b.dy);

  final dotProduct = ab.dx * bc.dx + ab.dy * bc.dy;
  final magnitudeAB = sqrt(pow(ab.dx, 2) + pow(ab.dy, 2));
  final magnitudeBC = sqrt(pow(bc.dx, 2) + pow(bc.dy, 2));

  final angleInRadians = acos(dotProduct / (magnitudeAB * magnitudeBC));
  final angleInDegrees = angleInRadians * (180 / pi);

  return angleInDegrees;
}

double calculateClockwiseAngle(Offset a, Offset b, Offset c) {
  final ab = Offset(b.dx - a.dx, b.dy - a.dy);
  final ac = Offset(c.dx - a.dx, c.dy - a.dy);

  final dotProduct = ab.dx * ac.dx + ab.dy * ac.dy;
  final magnitudeAB = sqrt(pow(ab.dx, 2) + pow(ab.dy, 2));
  final magnitudeAC = sqrt(pow(ac.dx, 2) + pow(ac.dy, 2));

  final angleInRadians = acos(dotProduct / (magnitudeAB * magnitudeAC));
  final angleInDegrees = angleInRadians * (180 / pi);

  // Determine the sign of the angle based on the cross product
  final crossProduct = ab.dx * ac.dy - ab.dy * ac.dx;
  final signedAngleInDegrees = crossProduct >= 0 ? angleInDegrees : 360 - angleInDegrees;

  return signedAngleInDegrees;
}

Rect rotateRectangle(Rect rect, double degrees, Offset center) {
  // Translate the rectangle to align with the origin (center)
  final translatedRect = rect.translate(-center.dx, -center.dy);

  // Apply the rotation transformation to the translated rectangle
  final transformedRect = MatrixUtils.transformRect(
    Matrix4.rotationZ(degreesToRadians(degrees)),
    translatedRect,
  );

  // Translate the transformed rectangle back to its original position
  final finalRect = transformedRect.translate(center.dx, center.dy);

  return finalRect;
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}
