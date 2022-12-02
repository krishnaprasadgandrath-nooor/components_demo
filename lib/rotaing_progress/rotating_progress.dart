import 'dart:math' as math;

import 'package:flutter/material.dart';

double dp(double val, int places) {
  num mod = math.pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

class RotatingProgress extends StatefulWidget {
  const RotatingProgress({super.key});

  @override
  State<RotatingProgress> createState() => _RotatingProgressState();
}

class _RotatingProgressState extends State<RotatingProgress> with SingleTickerProviderStateMixin {
  bool isRedFront = true;
  Duration durat = const Duration(seconds: 3);
  late final AnimationController _animController = AnimationController(
      lowerBound: 0.0, upperBound: 1.0, vsync: this, duration: durat, reverseDuration: durat, value: 0);

  late Animation<double> rotatTween =
      Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animController, curve: Curves.decelerate));

  @override
  void initState() {
    _animController.forward();
    rotatTween.addListener(() {
      if (rotatTween.isCompleted && !_animController.isAnimating) {
        _animController.value = 0;
        _animController.forward();
      }
      if (dp(rotatTween.value, 2) == 0.25 && isRedFront != false) {
        isRedFront = false;
        setState(() {});
      }
      if (dp(rotatTween.value, 2) == 0.75 && isRedFront != true) {
        isRedFront = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: rotatTween,
      builder: (context, child) => Transform(
        transform: Matrix4.rotationY(rotatTween.value * math.pi * 2),
        origin: Offset(10, 0),
        // scale: _animController.value,
        alignment: Alignment.centerRight,
        child: child,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(10.0)),
            // boxShadow: [
            //   BoxShadow(offset: Offset(-5, 2), color: Colors.red.withAlpha(50), blurRadius: 5.0, spreadRadius: 5.0)
            // ],
            color: /*isRedFront ?*/ Colors.red /* : Colors.lightBlue*/),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 20,
                  width: 20,
                  color: Colors.yellow,
                ),
              ),
              Center(
                  child: //isRedFront
                      //?
                      Text("Front")
                  // : Transform(
                  //     transform: Matrix4.rotationY(math.pi), alignment: Alignment.center, child: Text("Reverse")),
                  // child: Transform(
                  //   transform: isRedFront ? Matrix4.identity() : Matrix4.rotationY(math.pi),
                  //   child: CircularProgressIndicator(
                  //     valueColor: AlwaysStoppedAnimation(isRedFront ? Colors.lightBlue : Colors.red),
                  //   ),
                  // ),
                  ),
            ],
          ),
        ),
      ),
    ));
  }
}
