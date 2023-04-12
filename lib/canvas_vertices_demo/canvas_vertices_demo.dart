import 'dart:math';
import 'dart:ui';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class CanvasVerticesDemo extends StatefulWidget {
  const CanvasVerticesDemo({super.key});

  @override
  State<CanvasVerticesDemo> createState() => _CanvasVerticesDemoState();
}

class _CanvasVerticesDemoState extends State<CanvasVerticesDemo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(seconds: 2), reverseDuration: const Duration(seconds: 2))
    ..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Canvas Vertices Demo"),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.rotate(
          angle: _controller.value * pi,
          child: child,
        ),
        child: CustomPaint(
          painter: VerticesPainter(_controller),
          child: const SizedBox.expand(
            child: Center(child: Text("Hello")),
          ),
        ),
      ),
    );
  }
}

class VerticesPainter extends CustomPainter {
  final AnimationController controller;
  VerticesPainter(this.controller) : super(repaint: controller);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final positions = <Offset>[
      center,
      center + Offset(100, 0), //1
      center + Offset(50, -75), //2
      center + Offset(0, -100), //3
      center + Offset(-50, -75), //4
      center + Offset(-100, 0), //5
      center + Offset(-50, 75), //6
      center + Offset(0, 100), //7
      center + Offset(50, 75), //8
      center + Offset(100, 0), //9
    ];
    final vertices = Vertices(VertexMode.triangleFan, positions);
    canvas.drawVertices(vertices, BlendMode.lighten, Paint()..color = Colors.black.withOpacity(0.6));

    // canvas.drawRect(Rect.largest, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
