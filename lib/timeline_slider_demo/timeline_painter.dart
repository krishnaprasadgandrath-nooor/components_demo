import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'package:flutter/material.dart';

class TimelinePainter extends CustomPainter {
  TimelinePainter() : super();
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPaint(
    //     Paint()..color = Color.fromARGB(100, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)));
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke;
    for (double i = 0; i < size.width; i = i + 10) {
      Path path = Path();
      path.moveTo(i, 0);
      path.lineTo(i, i % 100 == 0 ? 10 : 5);
      canvas.drawPath(path, paint);
      if (i % 100 == 0) {
        TextSpan span =
            TextSpan(text: "${Duration(seconds: (i / 100).toInt()).toMMSS}", style: TextStyle(fontSize: 10.0));
        TextPainter textPainter = TextPainter(text: span, textDirection: TextDirection.ltr);
        textPainter.layout(maxWidth: 100, minWidth: 0);
        textPainter.paint(canvas, Offset(i, 12));
      }
    }
  }
}
