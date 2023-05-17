import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'timings_editor_view.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class TimingsEditorScreen extends StatefulWidget {
  const TimingsEditorScreen({super.key});

  @override
  State<TimingsEditorScreen> createState() => _TimingsEditorScreenState();
}

class _TimingsEditorScreenState extends State<TimingsEditorScreen> {
  Duration _startTime = const Duration(seconds: 2);
  Duration _endTime = const Duration(minutes: 2, seconds: 2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Timings Editor View Demo"),
      body: Center(
        child: Column(
          children: [
            TimingsEditor(
              initialStartTime: _startTime,
              initialEndTime: _endTime,
              onTimeChanged: (startTime, endTime) {
                _startTime = startTime;
                _endTime = endTime;
                setState(() {});
              },
            ),
            Text("${_startTime.toHHMMSS} - ${_endTime.toHHMMSS}")
          ],
        ),
      ),
    );
  }
}
