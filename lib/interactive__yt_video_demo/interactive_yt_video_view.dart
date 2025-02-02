import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as ypf;

class InteractiveYTVideoView extends StatefulWidget {
  final List<String> videoUrls;

  const InteractiveYTVideoView(
      {this.videoUrls = const [
        'https://youtu.be/in2P0O3fMf0',
        // 'https://youtu.be/CSyDiUbjtTE',
        // 'https://youtu.be/VUj1PbvnHS4'
      ],
      super.key});

  @override
  State<InteractiveYTVideoView> createState() => _InteractiveYTVideoViewState();
}

class _InteractiveYTVideoViewState extends State<InteractiveYTVideoView> {
  // List<YoutubePlayerController> _controllers = [];
  YoutubePlayerController? baseController;
  Duration _currTime = Duration.zero;
  final _targetDuration = const Duration(seconds: 15);
  GlobalKey ytKey = GlobalKey();

  @override
  void initState() {
    initAllControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: YoutubePlayer(
                controller: baseController!,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(_currTime.toString()),
            ),
            // if (_showPrompts) ...[
            //   Align(
            //     alignment: const Alignment(-0.3, 0.7),
            //     child: SizedBox.fromSize(
            //       size: const Size(200, 200),
            //       child: YoutubePlayer(controller: _controllers[1]),
            //     ),
            //   ),
            //   Align(
            //     alignment: const Alignment(0.3, 0.7),
            //     child: SizedBox.fromSize(
            //       size: const Size(200, 200),
            //       child: YoutubePlayer(key: ytKey, controller: _controllers[2]),
            //     ),
            //   )
            // ]
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  final state = await baseController!.playerState;
                  // baseController!.pauseVideo();
                  if (state == PlayerState.playing) baseController!.pauseVideo();
                  if (state == PlayerState.paused) baseController!.playVideo();
                  if (state == PlayerState.unknown) baseController!.pauseVideo();
                },
                icon: const Icon(Icons.play_arrow)),
            IconButton(
                onPressed: () {
                  final seekTo = _currTime + const Duration(seconds: 6);
                  baseController!.seekTo(seconds: seekTo.inSeconds.toDouble());
                  baseController!.playVideo();
                  setState(() {});
                },
                icon: const Icon(Icons.forward_10)),
          ],
        )
      ],
    );
  }

  void initAllControllers() {
    // for (var element in widget.videoUrls) {
    var element = widget.videoUrls.first;
    String? videoId = ypf.YoutubePlayer.convertUrlToId(element);
    if (videoId == null) throw Exception("Failed converting video to id");
    YoutubePlayerController controller = YoutubePlayerController.fromVideoId(videoId: videoId);
    // if (widget.videoUrls.indexOf(element) == 0) {
    baseController = controller;
    // addListener();
    baseController!.playVideo();
    baseController!.mute();
    // }
    // _controllers.add(controller);
    // }
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
      if (_currTime == _targetDuration) {
        setState(() {});
      }
    }
  }
}
