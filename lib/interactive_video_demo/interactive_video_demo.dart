import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:video_player/video_player.dart';

class InteractiveVideoDemo extends StatefulWidget {
  final List<String> videoUrls;
  const InteractiveVideoDemo(
      {super.key,
      this.videoUrls = const [
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      ]});

  @override
  State<InteractiveVideoDemo> createState() => _InteractiveVideoDemoState();
}

class _InteractiveVideoDemoState extends State<InteractiveVideoDemo> {
  final List<VideoPlayerController> _controllers = [];
  VideoPlayerController? baseController;
  Duration _currTime = Duration.zero;
  final Duration _targetDuration = const Duration(minutes: 1);

  bool _showPromprts = false;
  bool _canShow = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), initcontrollers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: !(false)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              )
            // ignore: dead_code
            : null,
        title: const Text("Interactive Vide Demo"),
        actions: const [
          // SizedBox(height: 50.0, width: 50.0, child: CircularProgressIndicator(color: Colors.white)),
        ],
      ),
      body: Stack(
        children: [
          if (_canShow) ...[
            SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Stack(
                  children: [
                    VideoPlayer(baseController!),
                    const SizedBox.expand(),
                  ],
                ),
              ),
            ),
            //  const Center(
            //     child: CircularProgressIndicator(),
            //   ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Text("$_currTime/${baseController!.value.duration}"),
            ),
          ],
          if (_showPromprts) ...[
            Align(
              alignment: const Alignment(-0.3, 0.7),
              child: SizedBox(
                height: 100,
                width: 200,
                child: PointerInterceptor(
                    child: InkWell(
                  onTap: () {
                    baseController!.pause();
                    baseController = _controllers[1];
                    setState(() {});
                    baseController!.play();
                  },
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.red),
                    child: SizedBox.expand(),
                  ),
                )),
              ),
            ),
            Align(
              alignment: const Alignment(0.3, 0.7),
              child: SizedBox(
                height: 100,
                width: 200,
                child: VideoPlayer(_controllers[2]),
              ),
            )
          ]
        ],
      ),
    );
  }

  void initcontrollers() {
    for (var element in widget.videoUrls) {
      if (widget.videoUrls.indexOf(element) != 0) return;
      VideoPlayerController controller = VideoPlayerController.network(element)..initialize();
      _controllers.add(controller);
      baseController = controller;
      addListener();
      _canShow = true;
      setState(() {});
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // _controllers.first.play();
        _controllers.first.seekTo(const Duration(seconds: 55));
        _controllers.first.play();

        initializeOtherController();
      });
    }

    setState(() {});
  }

  void initializeOtherController() {
    for (var element in widget.videoUrls) {
      if (widget.videoUrls.indexOf(element) == 0) continue;
      _controllers.add(VideoPlayerController.network(element)..initialize());
    }
  }

  void addListener() {
    assert(baseController != null);
    baseController!.addListener(durationListener);
  }

  void durationListener() {
    final time = baseController!.value.position;

    if (time != _currTime) {
      _currTime = time;
      if (_currTime.inSeconds == _targetDuration.inSeconds) _showPromprts = true;
      setState(() {});
    }
  }
}
