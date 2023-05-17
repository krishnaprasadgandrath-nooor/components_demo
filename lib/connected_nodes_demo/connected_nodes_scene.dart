import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class SimpleBall {
  late double x;
  late double y;

  late double radius;
  late double xSpeed;
  late double ySpeed;

  SimpleBall({
    required double width,
    required double height,
  }) {
    x = Random().nextDouble() * width;
    y = Random().nextDouble() * height;

    radius = Random().nextDouble() * 8 + 2;

    xSpeed = Random().nextDouble() * 1.5 - 0.75;
    ySpeed = Random().nextDouble() * 1.0 - 0.5;
  }
}

class ConnectedNodesScene extends GSprite {
  List<SimpleBall> balls = [];

  double get stageWidth => stage!.stageWidth;
  double get stageHeight => stage!.stageHeight;

  final linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final ballPaint = Paint()..style = PaintingStyle.fill;

  // Get the number of balls to create based on the stage size.
  // if size is too small (<100) reduce it more.
  // take an average of 25pt per "node".
  int _axisCount(double value) => (value < 100 ? value * 0.6 : value) ~/ 25;

  @override
  void addedToStage() {
    super.addedToStage();
    stage!.onResized.add(_onStageResize);
    _init(20);
  }

  _onStageResize() {
    var total = _axisCount(stageWidth) * _axisCount(stageHeight);
    // clamp the total to a reasonable range.
    total = total.clamp(10, 300);
    // if the difference is too big, re-init the system.
    final difference = total - balls.length;
    if (difference.abs() > 100) {
      _init(total);
    }
  }

  Future<void> _init(int count) async {
    balls.clear();
    for (int i = 0; i < count; i++) {
      balls.add(SimpleBall(width: stageWidth, height: stageHeight));
    }
  }

  // Eucledian distance formula {distance between two points}
  // double _distance(double x1, double y1, double x2, double y2) {
  //   return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  // }

  // Distance gross approximation
  double _distanceFast(double x1, double y1, double x2, double y2, double maxDistance) {
    final dx = (x1 - x2).abs();
    if (dx > maxDistance) {
      return maxDistance;
    }
    final dy = (y1 - y2).abs();
    if (dy > maxDistance) {
      return maxDistance;
    }
    return max(dx, dy);
  }

  @override
  void paint(Canvas canvas) {
    canvas.save();
    for (var i = 0; i < balls.length; i++) {
      var ball = balls[i];

      ///Changing ball direction on touching the  horizontal end
      if (ball.x < 0) {
        ball.x = 0;
        ball.xSpeed *= -1;
      } else if (ball.x > stageWidth) {
        ball.x = stageWidth;
        ball.xSpeed *= -1;
      }

      ///Changing ball direction on touching the  vertical end
      if (ball.y < 0) {
        ball.y = 0.0;
        ball.ySpeed *= -1;
      } else if (ball.y > stageHeight) {
        ball.y = stageHeight;
        ball.ySpeed *= -1;
      }
      //Updating ball position
      ball.x += ball.xSpeed;
      ball.y += ball.ySpeed;

      ///Drawing nearby lines
      int near = 0;
      const maxDistance = 60.0;
      for (var j = i + 1; j < balls.length; j++) {
        final nextBall = balls[j];
        final distance = _distanceFast(ball.x, ball.y, nextBall.x, nextBall.y, maxDistance);

        if (distance < maxDistance) {
          linePaint.color = const Color.fromARGB(255, 255, 2555, 255).withOpacity(1 - (distance / maxDistance));
          linePaint.strokeWidth = 4 - 4 * (distance / maxDistance);
          final offset1 = Offset(ball.x, ball.y);
          final offset2 = Offset(nextBall.x, nextBall.y);
          canvas.drawLine(offset1, offset2, linePaint);
          near++;
        }
      }

      ballPaint.color = Color.lerp(Colors.greenAccent, Colors.blueAccent, min((near / 10), 1)) ?? Colors.purple;

      canvas.drawCircle(
        Offset(ball.x, ball.y),
        ball.radius,
        ballPaint,
      );
    }
    canvas.restore();
  }
}
