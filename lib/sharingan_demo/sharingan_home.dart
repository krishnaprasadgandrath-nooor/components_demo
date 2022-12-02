// sharingan_home.dart

import 'dart:math';

import 'package:components_demo/sharingan_demo/tomoe_painter.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class SharinganHome extends StatefulWidget {
  final PaintingStyle strokeStyle = PaintingStyle.fill;
  final Color primaryColor = Colors.red;
  final Color secondaryColor = Colors.black;
  const SharinganHome({super.key});

  @override
  State<SharinganHome> createState() => _SharinganHomeState();
}

class _SharinganHomeState extends State<SharinganHome> with SingleTickerProviderStateMixin {
  double strokeSize = 8;
  late AnimationController animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
  late Animation<double> animation =
      Tween(begin: 0.0, end: 720.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeInOutSine));

  @override
  void initState() {
    // animationController.forward();
    super.initState();
    animationController.addListener(() {
      setState(() {});
      if (animationController.isCompleted && animationController.value == animationController.upperBound) {
        animationController.repeat();
        // animationController.value = 0;
        // setState(() {});

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Sharingan Demo"),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MouseRegion(
              onHover: (event) {
                animationController.isAnimating == false ? animationController.forward() : null;
              },
              onExit: (event) {
                animationController.isAnimating
                    ? animationController.animateTo(animationController.upperBound).then((value) {
                        animationController.stop();
                        animationController.value = 0;
                        setState(() {});
                      })
                    : null;
              },
              child: GestureDetector(
                // onTap: () {
                //   animationController.isAnimating
                //       ? animationController.animateTo(animationController.upperBound).then((value) {
                //           animationController.stop();
                //           animationController.value = 0;
                //         })
                //       : animationController.forward();
                // },
                child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ///Red LArge Filled
                        AnimatedContainer(
                          duration: kThemeAnimationDuration,
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: widget.primaryColor),
                              color: widget.primaryColor,
                              boxShadow: [
                                // BoxShadow(
                                //   color: Colors.red,
                                //   blurRadius: 15.0,
                                //   spreadRadius: 10.0,
                                //   blurStyle: BlurStyle.solid,
                                // ),
                                if (animationController.isAnimating)
                                  const BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 15.0,
                                    spreadRadius: 20.0,
                                  ),

                                // const BoxShadow(
                                //   color: Colors.red,
                                //   blurRadius: 15.0,
                                //   spreadRadius: 10.0,
                                //   blurStyle: BlurStyle.outer,
                                // ),
                              ]),
                        ),

                        ///Red Large Filled
                        Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: Colors.black, width: strokeSize)),
                        ),

                        ///Black Small Stroked
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: Colors.black, width: strokeSize)),
                        ),

                        ///Black Smallest Filled
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        AnimatedBuilder(
                            animation: animation,
                            builder: (context, child) => Transform.rotate(
                                  angle: (pi / 180) * animation.value,
                                  alignment: Alignment.center,
                                  child: SizedBox.expand(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: tomoeElements(),
                                    ),
                                  ),
                                ))
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> tomoeElements() {
    return [
      Transform.translate(
        offset: Offset(0, -110),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(270 / 360),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(pi),
            child: SizedBox(
              height: 30,
              width: 30,
              child: CustomPaint(
                painter: TomoePainter(tomoePaint: Paint()..color = Colors.black),
              ),
            ),
          ),
        ),
      ),
      Transform.translate(
        offset: pointOnCircle(110, 30, Offset(0, 0)),
        child: RotatedBox(
          quarterTurns: 2,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: SizedBox(
              height: 30,
              width: 30,
              child: CustomPaint(
                painter: TomoePainter(tomoePaint: Paint()..color = Colors.black),
              ),
            ),
          ),
        ),
      ),
      Transform.translate(
        offset: pointOnCircle(110, 150, Offset.zero),
        child: RotatedBox(
          quarterTurns: 2,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(pi),
            child: SizedBox(
              height: 30,
              width: 30,
              child: CustomPaint(
                painter: TomoePainter(tomoePaint: Paint()..color = Colors.black),
              ),
            ),
          ),
        ),
      )
    ];
  }

  Offset pointOnCircle(double radius, double angleInDegrees, Offset origin) {
    // Convert from degrees to radians via multiplication by PI/180
    double x = (radius * cos(angleInDegrees * pi / 180)) + origin.dx;
    double y = (radius * sin(angleInDegrees * pi / 180)) + origin.dy;

    return Offset(x, y);
  }
}
