import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as ypf;

class SimpleYTControls extends StatefulWidget {
  const SimpleYTControls({super.key});

  @override
  State<SimpleYTControls> createState() => _SimpleYTControlsState();
}

class _SimpleYTControlsState extends State<SimpleYTControls> {
  final String ytId = "https://youtu.be/in2P0O3fMf0";
  YoutubePlayerController? baseController;
  PlayerState _playerState = PlayerState.unknown;
  Duration _currTime = Duration.zero;
  Duration _duration = Duration.zero;
  final _targetDuration = const Duration(seconds: 15);
  GlobalKey ytKey = GlobalKey();
  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Youtube Controls Demo"),
      body: Column(
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
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    PlayerState state = await baseController!.playerState;
                    // baseController!.pauseVideo();
                    if (state == PlayerState.playing) {
                      baseController!.pauseVideo();
                    } else {
                      baseController!.playVideo();
                    }
                  },
                  icon: Icon(
                    _playerState == PlayerState.playing
                        ? Icons.pause
                        : _playerState == PlayerState.paused
                            ? Icons.play_arrow
                            : Icons.abc,
                  )),
              IconButton(
                  onPressed: () async {
                    double time = await baseController!.currentTime;
                    // final seekTo = Duration(seconds: time.toInt()) + Duration(seconds: 6);

                    baseController!.seekTo(seconds: (time + 6));
                    baseController!.playVideo();
                    baseController!.update();
                  },
                  icon: const Icon(Icons.forward_10)),
              Text('${_currTime.toString().split(".").first}/${_duration.toString().split(".").first}'),
            ],
          )
        ],
      ),
    );
  }

  void initController() {
    // for (var element in widget.videoUrls) {

    String? videoId = ypf.YoutubePlayer.convertUrlToId(ytId);
    if (videoId == null) throw Exception("Failed converting video to id");

    baseController = YoutubePlayerController.fromVideoId(videoId: videoId);

    _duration = baseController!.value.metaData.duration;

    // addListener();
    baseController!.playVideo();
    baseController!.mute();
    addListeners();
    _duration = baseController!.value.metaData.duration;
    setState(() {});
  }

  void addListeners() {
    stateListener();
    baseController!.videoStateStream.any((element) {
      posListener();
      return false;
    });
  }

  void stateListener() {
    baseController!.stream.listen((event) {
      if (_playerState != event.playerState) {
        _playerState = event.playerState;
        setState(() {});
      }
    });
  }

  Future<void> posListener() async {
    double elapsedTime = await baseController!.currentTime;
    final time = Duration(seconds: elapsedTime.toInt());
    if (time != _currTime) {
      _currTime = time;
      // if (_currTime == _targetDuration) _showPrompts = true;
      setState(() {});
    }
  }
}
