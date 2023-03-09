import 'dart:async';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CSliderDemo extends StatefulWidget {
  const CSliderDemo({super.key});

  @override
  State<CSliderDemo> createState() => _CSliderDemoState();
}

class _CSliderDemoState extends State<CSliderDemo> with SingleTickerProviderStateMixin {
  Timer? timer;
  Duration _duration = Duration.zero;
  final Duration sDuration = const Duration(seconds: 1);
  final Duration duration2 = const Duration(minutes: 2, milliseconds: 1);

  late Duration checkDuration = _duration;

  late Ticker _ticker;

  List<Duration> customTicks = [];

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(tickerListener);
    _ticker.start();
  }

  void updateDuratio() {
    _duration = const Duration(seconds: 1) + _duration;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "C Slider Demo"),
      body: Column(
        children: [
          Text(_duration.toString().split(".").first),
          ConstrainedBox(
            constraints: const BoxConstraints.expand(width: 200, height: 60),
            child: Stack(
              children: [
                ColoredBox(
                  color: Colors.red,
                  child: Slider(
                    value: _duration.inMilliseconds.toDouble(),
                    min: 0,
                    max: duration2.inMilliseconds.toDouble(),
                    onChanged: (value) {
                      _duration = Duration(milliseconds: value.toInt());
                      checkDuration = _duration;
                      _ticker.stop();

                      _ticker = Ticker(tickerListener);
                      _ticker.start();
                      // timer?.cancel();
                      // timer = Timer(const Duration(minutes: 2) - _duration, updateDuratio);
                    },
                  ),
                ),
                // customTicks.map((e) => null).toList()
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  final tick = Duration(seconds: _duration.inSeconds);
                  customTicks.add(tick);
                },
                icon: const Icon(Icons.add)),
          )
        ],
      ),
    );
  }

  void tickerListener(elapsed) {
    if (checkDuration + elapsed >= duration2) {
      _ticker.stop();
      setState(() {});
    } else {
      _duration = checkDuration + elapsed;
      setState(() {});
    }
  }
}
