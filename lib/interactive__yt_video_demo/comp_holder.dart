import 'package:components_demo/interactive__yt_video_demo/c_action_button.dart';
import 'package:components_demo/interactive__yt_video_demo/card_component.dart';
import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';
import 'image_component.dart';

class YtCompHolder extends StatefulWidget {
  final SimpleComponent component;
  final YoutubePlayerController vController;
  const YtCompHolder(
    this.component, {
    required this.vController,
    super.key,
  });

  @override
  State<YtCompHolder> createState() => _YtCompHolderState();
}

class _YtCompHolderState extends State<YtCompHolder> {
  @override
  void initState() {
    super.initState();
    if (widget.component.pauseOnDisplay) {
      widget.vController.pauseVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.component.rect.left,
      top: widget.component.rect.top,
      width: widget.component.rect.width,
      height: widget.component.rect.height,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(seconds: 1),
        builder: (context, value, child) => Opacity(opacity: value, child: child),
        child: PointerInterceptor(child: ConstrainedBox(constraints: const BoxConstraints.expand(), child: getCompView())),
      ),
    );
  }

  Widget getCompView() {
    switch (widget.component.type) {
      case CompType.image:
        return ImageComponent(image: widget.component.data);
      case CompType.button:
        return CActionButton(
            child: Center(
              child: Text(
                "${widget.component.data['title']}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
            onClick: () {
              Duration? duration = DurationParser.fromHHMMSS(widget.component.data['to']);
              if (duration != null) {
                widget.vController.seekTo(seconds: duration.inSeconds.toDouble(), allowSeekAhead: true);
              }
            });
      case CompType.question:
        return CardComponent(data: widget.component.data);
      case CompType.link:
        return Card(
            color: Colors.black,
            child: Row(
              children: [
                const Icon(
                  Icons.link,
                  color: Colors.orange,
                ),
                TextButton(
                    onPressed: () {
                      final Uri url = Uri.parse(widget.component.data['url']);
                      launchInBrowser(url);
                    },
                    child: Text("${widget.component.data['title']}",
                        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)))
              ],
            ));
      default:
        return Card(
          margin: const EdgeInsets.all(3.0),
          color: Colors.yellow,
          child: Center(
            child: Text(
              widget.component.data.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
    }
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
