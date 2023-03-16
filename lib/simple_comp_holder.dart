import 'dart:async';

import 'package:components_demo/timeline_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SimpleCompPage extends StatefulWidget {
  const SimpleCompPage({super.key});

  @override
  State<SimpleCompPage> createState() => _SimpleCompPageState();
}

class _SimpleCompPageState extends State<SimpleCompPage> with SingleTickerProviderStateMixin {
  final Duration _duration = Duration(minutes: 2);
  StreamController<Duration> posStream = StreamController<Duration>();
  late Ticker ticker = Ticker((elapsed) {
    if (elapsed > _duration) {
      ticker.stop();
    } else {
      posStream.sink.add(elapsed);
    }
  });
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ticker.start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Simple Compoent Holder"),
      ),
      body: Center(
        /// Place Component Here
        child: SizedBox(
          height: 30,
          width: 500,
          child: ColoredBox(
              color: Colors.redAccent,
              child: TimeLineSlider(
                positionStream: posStream.stream,
                duration: _duration,
              )),
        ),
      ),
    );
  }
}
