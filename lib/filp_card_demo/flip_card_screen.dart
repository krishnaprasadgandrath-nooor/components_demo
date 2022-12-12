import 'dart:math' as math;
import 'dart:ui';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

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
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Opacity(
                    opacity: 0.3,
                    child: Transform(
                      transform: Matrix4.rotationX((_sliderValue / 2) * (math.pi / 180)),
                      alignment: Alignment.center,
                      child: Transform(
                        transform: Matrix4.rotationY((_sliderValue / 2) * (math.pi / 180)),
                        alignment: Alignment.center,
                        child: Transform(
                          transform: Matrix4.rotationZ((_sliderValue / 2) * (math.pi / 180)),
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.red,
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(20.0),
                            child: const Center(
                              child: Text("Hello"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Transform(
                  transform: Matrix4.rotationX(_sliderValue * (math.pi / 180)),
                  alignment: Alignment.center,
                  child: Transform(
                    transform: Matrix4.rotationY(-_sliderValue * (math.pi / 180)),
                    alignment: Alignment.center,
                    child: Transform(
                      transform: Matrix4.rotationZ(_sliderValue * (math.pi / 180)),
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.red,
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(20.0),
                        child: const Center(
                          child: Text("Hello"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Slider(
              value: _sliderValue,
              min: 0,
              max: 10,
              // divisions: 10,
              onChanged: (value) => setState(() {
                _sliderValue = value;
                // print(_sliderValue);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
      // Transform(
          //   transform: Matrix4.rotationY(-_sliderValue * (math.pi / 180)),
          //   alignment: Alignment.center,
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 10.0),
          //     padding: EdgeInsets.symmetric(horizontal: 20.0),
          //     decoration: BoxDecoration(boxShadow: [
          //       BoxShadow(
          //           color: Colors.red.withAlpha(60), blurRadius: 10.0, spreadRadius: 3.0, blurStyle: BlurStyle.inner)
          //     ]),
          //     child: Center(child: Text("")),
          //   ),
          // ),

          // Container(
          //   height: 200,
          //   width: 200,
          //   color: Colors.black,
          //   child: Stack(
          //     alignment: Alignment.center,
          //     fit: StackFit.expand,
          //     children: [
          //       Icon(
          //         Icons.add,
          //         color: Colors.white,
          //         size: 30.0,
          //       ),
          //       Icon(Icons.add),
          //     ],
          //   ),
          // )