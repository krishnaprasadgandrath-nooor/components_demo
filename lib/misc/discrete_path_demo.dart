import 'dart:math';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

const violet = Color(0xff9400d3);
const indigo = Color(0xff4b0082);
const blue = Color(0xff0000ff);
const green = Color(0xff00ff00);
const yellow = Color(0xffffff00);
const orange = Color(0xffff7f00);
const red = Color(0xffff0000);

class DiscretePathDemo extends StatefulWidget {
  const DiscretePathDemo({super.key});

  @override
  State<DiscretePathDemo> createState() => _DiscretePathDemoState();
}

class _DiscretePathDemoState extends State<DiscretePathDemo> with SingleTickerProviderStateMixin {
  final duration = const Duration(seconds: 5);
  late AnimationController controller = AnimationController(vsync: this, duration: duration);

  @override
  void initState() {
    super.initState();
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Non Continous PAth Demo"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CustomPaint(
            painter: _CustomPainter(controller),
            child: const SizedBox(height: 300, width: 300),
          ),
        ),
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  final AnimationController controller;
  _CustomPainter(this.controller) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final gradient = SweepGradient(
      colors: [
        violet,
        Color.lerp(violet, indigo, 0.5)!,
        indigo,
        Color.lerp(indigo, blue, 0.5)!,
        blue,
        Color.lerp(blue, green, 0.5)!,
        green,
        Color.lerp(green, yellow, 0.5)!,
        yellow,
        Color.lerp(yellow, orange, 0.5)!,
        orange,
        Color.lerp(orange, red, 0.5)!,
        red,
        Color.lerp(red, violet, 0.5)!,
      ],
      /* begin: Alignment.topLeft, end: Alignment.bottomRight,  */
      tileMode: TileMode.decal,
      center: Alignment.center,
      startAngle: (pi / 180) * (controller.value * 360),
      endAngle: ((pi / 180) * (controller.value * 360)) + controller.value,
      // transform: GradientRotation(pi / 180 * (controller.value * 360.0)),
    );

    final paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTRB(0, 0, height, width))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    Path path = Path();
    /* canvas.transform((Matrix4.identity()
          ..scale(0.75)
          ..translate(width * 0.25, height * 0.25) /* ..rotateZ(pi / 3) */)
        .storage) */
    ;

    // letter E
    /* path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width * 0.5, size.height / 2); */

    ///Letter B
    /* path.cubicTo(width, height * 0.2, width, height * 0.3, 0, height * 0.5);
    path.quadraticBezierTo(width * 2, height * 0.75, 0, height);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint); */
    canvas.drawRect(Rect.fromLTRB(0, 0, width, height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
