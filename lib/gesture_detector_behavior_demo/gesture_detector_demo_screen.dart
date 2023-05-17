import 'dart:developer';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class GestureDetectorDemo extends StatefulWidget {
  const GestureDetectorDemo({super.key});

  @override
  State<GestureDetectorDemo> createState() => _GestureDetectorDemoState();
}

class _GestureDetectorDemoState extends State<GestureDetectorDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "GEsture Detector Behaviour"),
      body: Center(
        child: SizedBox(
          height: 50,
          width: 300,
          child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withAlpha(150), strokeAlign: BorderSide.strokeAlignOutside)),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Listener(
                onPointerDown: (event) {
                  log("Pointer Down");
                },
                onPointerCancel: (details) {
                  log("POINTER CANCEL");
                },
                onPointerMove: (event) {
                  log("Pointer moved");
                },
                onPointerUp: (event) {
                  log("Pointer UP");
                },
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                          500,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ColoredBox(
                                  color: Colors.accents[index % Colors.accents.length],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$index",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// onPanDown: (details) {
//                 print("PAn Down");
//               },
//               onPanCancel: () {
//                 print("Pan Cancelled");
//               },
//               onPanEnd: (details) {
//                 print("PanEnded");
//               },
//               onPanUpdate: (details) {
//                 print("PAn Update");
//               },