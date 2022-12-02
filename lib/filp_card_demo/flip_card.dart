import 'dart:math' as math;

import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  const FlipCard({super.key, required this.front, required this.back});

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late final AnimationController _flipController = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
      vsync: this,
      value: 0.0,
      animationBehavior: AnimationBehavior.preserve);

  @override
  void initState() {
    _flipController.addListener(() => setState(() {}));
    super.initState();
  }

  bool isFront = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _flipController,
          builder: (context, child) => Transform(
            transform: Matrix4.rotationY(math.pi * 180 * _flipController.value),
            child: child,
          ),
          child: SizedBox(
            height: 300,
            width: 300,
            child: Card(
              color: Colors.red,
            ),
          ),
        ),
        flipButton()
      ],
    );
  }

  Widget flipButton() {
    return Align(
      alignment: Alignment.bottomRight,
      child: IconButton(onPressed: startFlip, icon: Icon(Icons.shuffle)),
    );
  }

  void startFlip() {
    if (_flipController.value == 1) {
      _flipController.reverse().whenComplete(() => changeFlipStatus(true));
    } else {
      _flipController.forward().whenComplete(() => changeFlipStatus(false));
    }
  }

  void changeFlipStatus(bool value) {
    if (value != isFront) {
      isFront = value;
      setState(() {});
    }
  }
}
