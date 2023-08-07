import 'dart:math';

import 'package:flutter/material.dart';

class RectangleWithLinesPainter extends CustomPainter {
  final double sideLength; // Length of the rectangle side
  final int numberOfLines; // Number of lines to draw
  final double lineLength; // Length of each line
  final Color lineColor; // Color of the lines

  RectangleWithLinesPainter({
    required this.sideLength,
    required this.numberOfLines,
    required this.lineLength,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = lineColor;

    // Calculate the angle in radians for 30 degrees
    const double angleInRadians = pi / 6;

    // Calculate the coordinates of the center point of the rectangle
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw the rectangle
    final Rect rect = Rect.fromCenter(center: center, width: sideLength, height: sideLength);
    canvas.drawRect(rect, paint);

    // Calculate the coordinates of the starting point (top-left corner) of the first line
    double x = center.dx - sideLength / 2;
    double y = center.dy - sideLength / 2 - lineLength;

    // Draw the lines that stay inside the rectangle and rotate internally
    for (int i = 0; i < numberOfLines; i++) {
      // Calculate the endpoint of the line using trigonometry
      double endX = x + lineLength * cos(angleInRadians);
      double endY = y - lineLength * sin(angleInRadians);

      // Find the intersection point of the line with the rectangle's sides
      final Offset intersection = getIntersectionPoint(center, x, y, endX, endY);

      // Draw the line
      canvas.drawLine(Offset(x, y), Offset(intersection.dx, intersection.dy), paint);

      // Update the starting point for the next line
      x = intersection.dx;
      y = intersection.dy;
    }
  }

  // Function to find the intersection point of a line with the rectangle's sides
  Offset getIntersectionPoint(Offset center, double startX, double startY, double endX, double endY) {
    final Rect rect = Rect.fromCenter(center: center, width: sideLength, height: sideLength);

    // Find the intersection points of the line with the rectangle's sides
    final List<Offset> intersections = [];

    intersections.add(Line(start: Offset(rect.left, rect.top), end: Offset(rect.right, rect.top))
        .intersectionPoint(Offset(startX, startY), Offset(endX, endY)));
    intersections.add(Line(start: Offset(rect.right, rect.top), end: Offset(rect.right, rect.bottom))
        .intersectionPoint(Offset(startX, startY), Offset(endX, endY)));
    intersections.add(Line(start: Offset(rect.left, rect.bottom), end: Offset(rect.right, rect.bottom))
        .intersectionPoint(Offset(startX, startY), Offset(endX, endY)));
    intersections.add(Line(start: Offset(rect.left, rect.top), end: Offset(rect.left, rect.bottom))
        .intersectionPoint(Offset(startX, startY), Offset(endX, endY)));

    // Find the intersection point that lies inside the rectangle
    double minDistance = double.infinity;
    Offset intersectionPoint = Offset.zero;
    for (final intersection in intersections) {
      final double distance = center.distanceSquaredTo(intersection);
      if (rect.contains(intersection) && distance < minDistance) {
        minDistance = distance;
        intersectionPoint = intersection;
      }
    }
    return Offset(intersectionPoint.dx, intersectionPoint.dy);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RectangleWithLinesScreen extends StatelessWidget {
  const RectangleWithLinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectangle With Lines'),
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter: RectangleWithLinesPainter(
              sideLength: 100,
              numberOfLines: 10,
              lineLength: 30,
              lineColor: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RectangleWithLinesScreen(),
  ));
}

class Line {
  Offset start;
  Offset end;

  Line({
    required this.start,
    required this.end,
  });

  Offset intersectionPoint(Offset offset, Offset offset2) {
    double x1 = start.dx;
    double y1 = start.dy;
    double x2 = end.dx;
    double y2 = end.dy;

    double x3 = offset.dx;
    double y3 = offset.dy;
    double x4 = offset2.dx;
    double y4 = offset2.dy;

    double det = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (det == 0) {
      // Lines are parallel or coincident, return null as there's no unique intersection point
      return const Offset(double.infinity, double.infinity);
    } else {
      double x = ((x1 * y2 - y1 * x2) * (x3 - x4) - (x1 - x2) * (x3 * y4 - y3 * x4)) / det;
      double y = ((x1 * y2 - y1 * x2) * (y3 - y4) - (y1 - y2) * (x3 * y4 - y3 * x4)) / det;
      return Offset(x, y);
    }
  }
}

extension OffsetUtil on Offset {
  double distanceSquaredTo(Offset other) => sqrt(pow(other.dx - dx, 2) + pow(other.dy - dy, 2));
}
