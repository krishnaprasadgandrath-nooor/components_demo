import 'dart:async';
import 'dart:convert';

import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as ypf;

import 'comp_holder.dart';

class SimpleYTControls extends StatefulWidget {
  const SimpleYTControls({super.key});

  @override
  State<SimpleYTControls> createState() => _SimpleYTControlsState();
}

class _SimpleYTControlsState extends State<SimpleYTControls> {
  final String ytId = "https://youtu.be/xcJtL7QggTI";
  YoutubePlayerController? baseController;
  PlayerState _playerState = PlayerState.unknown;
  Duration _currTime = Duration.zero;
  Duration _duration = Duration.zero;
  // final _targetDuration = const Duration(seconds: 15);
  GlobalKey ytKey = GlobalKey();
  Set<SimpleComponent> components = {};
  StreamController<Set<String>> visibleComponentsController = StreamController();
  // late Stream<Set<String>> visibleComponentsStream = visibleComponentsController.stream;
  final Size size = const Size(600, 600);

  @override
  void initState() {
    initController();
    loadComponents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Youtube Controls Demo"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(size),
              child: Stack(
                children: [
                  SizedBox.expand(child: YoutubePlayer(controller: baseController!)),
                  StreamBuilder<Set<String>>(
                    stream: visibleComponentsController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Stack(
                          children: snapshot.data!
                              .map(
                                (e) => YtCompHolder(
                                  components.firstWhere((element) => element.id == e),
                                  vController: baseController!,
                                ),
                              )
                              .toList(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    double time = await baseController!.currentTime;
                    // final seekTo = Duration(seconds: time.toInt()) + Duration(seconds: 6);

                    baseController!.seekTo(seconds: (time - 6), allowSeekAhead: true);

                    baseController!.playVideo();
                  },
                  icon: const Icon(Icons.replay_10)),
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
                            : Icons.pause,
                  )),
              IconButton(
                  onPressed: () async {
                    double time = await baseController!.currentTime;
                    // final seekTo = Duration(seconds: time.toInt()) + Duration(seconds: 6);

                    baseController!.seekTo(seconds: (time + 6), allowSeekAhead: true);
                    baseController!.playVideo();
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

    baseController = YoutubePlayerController.fromVideoId(videoId: videoId)..setSize(size.width, size.height);

    _duration = baseController!.value.metaData.duration;

    // addListener();
    baseController!.playVideo();
    baseController!.mute();
    addListeners();
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
      final duration = event.metaData.duration;
      if (duration != Duration.zero && _duration != duration) {
        _duration = duration;
        setState(() {});
      }
    });
  }

  Future<void> posListener() async {
    double elapsedTime = await baseController!.currentTime;

    final time = Duration(seconds: elapsedTime.toInt());
    if (time != _currTime) {
      _currTime = time;
      checkAndAddComponents();
      setState(() {});
    }
  }

  Future<void> loadComponents() async {
    String rawJson = await rootBundle.loadString('assets/comp_data.json');
    final list = (jsonDecode(rawJson) as List).cast<Map<String, dynamic>>();
    for (var element in list) {
      components.add(SimpleComponent.fromMap(element));
      setState(() {});
    }
  }

  void checkAndAddComponents() {
    Set<String> visibleComponents = {};
    for (var element in components) {
      if (element.start_time.inSeconds <= _currTime.inSeconds && _currTime.inSeconds <= element.end_time.inSeconds) {
        visibleComponents.add(element.id);
      }
    }

    visibleComponentsController.sink.add(visibleComponents);
  }
}
