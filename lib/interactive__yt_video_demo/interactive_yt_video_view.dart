import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as ypf;

class InteractiveYTVideoView extends StatefulWidget {
  final List<String> videoUrls;

  const InteractiveYTVideoView(
      {this.videoUrls = const [
        'https://youtu.be/52ZkFD-YlmY',
        'https://youtu.be/CSyDiUbjtTE',
        'https://youtu.be/VUj1PbvnHS4'
      ],
      super.key});

  @override
  State<InteractiveYTVideoView> createState() => _InteractiveYTVideoViewState();
}

class _InteractiveYTVideoViewState extends State<InteractiveYTVideoView> {
  List<YoutubePlayerController> _controllers = [];
  YoutubePlayerController? baseController;
  Duration _currTime = Duration.zero;
  final _targetDuration = const Duration(seconds: 15);

  bool _showPrompts = false;
  @override
  void initState() {
    initAllControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: YoutubePlayer(
            controller: _controllers.first,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(_currTime.toString()),
        ),
        if (_showPrompts) ...[
          Align(
            alignment: const Alignment(-0.3, 0.7),
            child: SizedBox.fromSize(
              size: const Size(200, 200),
              child: YoutubePlayer(controller: _controllers[1]),
            ),
          ),
          Align(
            alignment: const Alignment(0.3, 0.7),
            child: SizedBox.fromSize(
              size: const Size(200, 200),
              child: YoutubePlayer(controller: _controllers[2]),
            ),
          )
        ]
      ],
    );
  }

  void initAllControllers() {
    for (var element in widget.videoUrls) {
      String? videoId = ypf.YoutubePlayer.convertUrlToId(element);
      if (videoId == null) throw Exception("Failed converting video to id");
      YoutubePlayerController controller = YoutubePlayerController.fromVideoId(videoId: videoId);
      if (widget.videoUrls.indexOf(element) == 0) {
        baseController = controller;
        addListener();
      }
      _controllers.add(controller);
    }
  }

  void addListener() async {
    assert(baseController != null);
    baseController!.videoStateStream.any((element) {
      durationListener();
      return false;
    });
  }

  durationListener() async {
    double elapsedTime = await baseController!.currentTime;
    final time = Duration(seconds: elapsedTime.toInt());
    if (time != _currTime) {
      _currTime = time;
      if (_currTime == _targetDuration) _showPrompts = true;
      setState(() {});
    }
  }
}
