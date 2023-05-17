import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class ClipAnimDemo extends StatefulWidget {
  const ClipAnimDemo({super.key});

  @override
  State<ClipAnimDemo> createState() => _ClipAnimDemoState();
}

class _ClipAnimDemoState extends State<ClipAnimDemo> with TickerProviderStateMixin {
  final duration = const Duration(seconds: 2);
  late final AnimationController _animController =
      AnimationController(vsync: this, duration: duration, reverseDuration: duration);

  late final Animation<double> _anim = CurvedAnimation(parent: _animController, curve: Curves.easeInSine);

  @override
  void initState() {
    super.initState();
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(duration ~/ 2, _animController.reverse);
      } else if (status == AnimationStatus.dismissed) {
        _animController.forward();
      }
    });
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Clip Anim Demo"),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Stack(fit: StackFit.expand, children: [
                CustomPaint(
                  painter: EyePainter(),
                ),
                ClipPath(
                  clipBehavior: Clip.antiAlias,
                  clipper: CustomPathClip(animation: _anim),
                  child: const ColoredBox(
                      color: Color(0xffF7CF5B),
                      child: SizedBox.expand(
                          // child: FlutterLogo(),
                          )),
                  // ),
                ),
              ])),
          const Expanded(
              flex: 3,
              child: ColoredBox(
                color: Color(0xff105491),
                child: SizedBox.expand(),
              )),
        ],
      ),
    );
  }
}

class EyePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    Paint paint = Paint()..color = Colors.black;
    canvas.drawCircle(Offset(size.width / 2, height), size.width * 0.3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class CustomPathClip extends CustomClipper<Path> {
  CustomPathClip({required this.animation}) : super(reclip: animation);
  final Animation<double> animation;

  @override
  bool shouldReclip(covariant CustomPathClip oldClipper) => false;

  @override
  getClip(Size size) {
    final height = size.height;
    final width = size.width;
    // final radius = math.min(height, width);
    // final Offset center = Offset(width / 2, height / 2);
    Path path = Path();
    //Revealing oval
    // path.moveTo(center.dx, center.dy);

    // path.addRRect(
    //   RRect.fromRectAndRadius(
    //       Rect.fromCenter(center: center, width: width * animation.value, height: height * animation.value),
    //       Radius.circular(radius * (1 - animation.value))),
    // );
    // path.addOval(
    //     Rect.fromCenter(center: center, width: size.width * animation.value, height: size.height * animation.value));

    path.moveTo(0, 0); //1
    path.lineTo(width, 0); //2;
    path.lineTo(width, height * 0.75); //3
    Offset offset4 = Offset(width * 0.75, (height * (0.75 + 0.25 * animation.value)));
    Offset offset5 = Offset(width * 0.5, (height * (0.75 * animation.value)));
    Offset offset6 = Offset(width * 0.25, (height * (0.75 + 0.25 * animation.value)));
    Offset offset7 = Offset(0, height * 0.75);
    path.quadraticBezierTo(offset4.dx, offset4.dy, offset5.dx, offset5.dy);
    path.quadraticBezierTo(offset6.dx, offset6.dy, offset7.dx, offset7.dy);
    // path.quadraticBezierTo(width, height, offset.dx, offset.dy);
    // path.relativeQuadraticBezierTo(width, height, 0, height);
    // path.relativeQuadraticBezierTo(offset.dx, offset.dy, 0, height);
    // path.relativeQuadraticBezierTo(x1, y1, x2, y2)
    // path.lineTo(0, height);
    // path.arcToPoint(Offset(0, height), clockwise: false, radius: Radius.circular(animation.value)

    // radius: Radius.circular((height / 16) * animation.value),
    // path.quadraticBezierTo(offset1.dx, offset1.dy, offset2.dx, offset2.dy);
    // path.quadraticBezierTo(offset2.dx, offset2.dy, offset3.dx, offset3.dy);
    path.lineTo(offset7.dx, offset7.dy);
    path.lineTo(0, 0);
    path.close();

    return path;
  }
}
