import 'dart:math' as math;
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class FlipCardScreen extends StatefulWidget {
  const FlipCardScreen({super.key});

  @override
  State<FlipCardScreen> createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardScreen> {
  double _sliderValue = 0.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Flip Card Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: Transform(
              transform: Matrix4.rotationY(_sliderValue * math.pi / 180),
              child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(20.0),
                color: Colors.red,
                child: Center(
                  child: Text("Hello"),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Slider(
              value: _sliderValue,
              min: 0,
              max: 1,
              divisions: 10,
              onChanged: (value) => setState(() {
                _sliderValue = value;
              }),
            ),
          )
        ],
      ),
    );
  }
}
