import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotatingProgress extends StatefulWidget {
  const RotatingProgress({super.key});

  @override
  State<RotatingProgress> createState() => _RotatingProgressState();
}

class _RotatingProgressState extends State<RotatingProgress> with SingleTickerProviderStateMixin {
  bool isRedFront = true;
  late final AnimationController _animController = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
      value: 0)
    ..repeat();

  late CurvedAnimation rotatTween = CurvedAnimation(parent: _animController, curve: Curves.easeInOut);

  @override
  void initState() {
    _animController.addListener(() {
      if (_animController.value == 0.25 && isRedFront != false) {
        isRedFront = false;
        setState(() {});
      }
      if (_animController.value == 0.75 && isRedFront != true) {
        isRedFront = true;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: rotatTween,
      builder: (context, child) => Transform(
        transform: Matrix4.rotationX(-_animController.value * math.pi * 2),
        // scale: _animController.value,
        alignment: Alignment.center,
        child: child,
      ),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: isRedFront ? Colors.red : Colors.lightBlue),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(isRedFront ? Colors.lightBlue : Colors.red),
            )),
      ),
    ));
  }
}
