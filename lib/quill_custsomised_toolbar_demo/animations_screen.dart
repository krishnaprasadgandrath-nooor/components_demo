import 'dart:math' as math;

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class AnimationsDemoScreen extends StatefulWidget {
  const AnimationsDemoScreen({super.key});

  @override
  State<AnimationsDemoScreen> createState() => _AnimationsDemoScreenState();
}

class _AnimationsDemoScreenState extends State<AnimationsDemoScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..addListener(() {
      setState(() {});
    });
  late final Animation<double> _flipAnim = CurvedAnimation(parent: _animController, curve: Curves.decelerate)
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "AnimationsDemoScreen"),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: AnimatedBuilder(
                animation: _flipAnim,
                builder: (context, child) {
                  final value = _flipAnim.value;
                  final angle = value * math.pi;
                  const perspective = 0.002;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, perspective)
                      ..rotateX(angle)
                    // ..rotateY(angle)
                    ,
                    child: child,
                  );
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 5.0, strokeAlign: BorderSide.strokeAlignOutside),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            color: Colors.grey.withAlpha(200),
                            blurRadius: 20.0,
                            spreadRadius: 5.0)
                      ]),
                  child: Column(
                    children: [
                      const Expanded(
                          child: SizedBox.expand(
                              // child: _flipAnim.value > 0.5 ?
                              //  Center(child: Container(margin: EdgeInsets.all(8.0), color: Colors.black))
                              // :
                              child: FlutterLogo())),
                      if (_flipAnim.value > 0.5)
                        Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Text(_flipAnim.value < 0.5 ? "Flutter Logo" : "Your Photo"))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50.0,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _animController.status == AnimationStatus.completed
                            ? _animController.reverse()
                            : _animController.forward();
                      },
                      icon: const Icon(Icons.replay))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
