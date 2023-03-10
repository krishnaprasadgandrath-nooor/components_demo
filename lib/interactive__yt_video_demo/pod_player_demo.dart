import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PodPlayerDemo extends StatefulWidget {
  const PodPlayerDemo({super.key});

  @override
  State<PodPlayerDemo> createState() => _PodPlayerDemoState();
}

class _PodPlayerDemoState extends State<PodPlayerDemo> {
  final String ytId = "https://youtu.be/xcJtL7QggTI";

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  late final PodPlayerController _controller = PodPlayerController(
    playVideoFrom: PlayVideoFrom.youtube(ytId),
  )
    ..initialise()
    ..addListener(listener);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Pod Player Demo"),
      body: Column(
        children: [
          PodVideoPlayer(controller: _controller),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [Text("${_position.toString().split(".").first}/${_duration.toString().split(".").first}")],
          )
        ],
      ),
    );
  }

  void listener() {
    if (_controller.currentVideoPosition != _position) {
      _position = _controller.currentVideoPosition;
      setState(() {});
    }
    if (_duration != _controller.totalVideoLength && _controller.totalVideoLength != Duration.zero) {
      _duration = _controller.totalVideoLength;
      setState(() {});
    }
  }
}
