import 'package:components_demo/interactive__yt_video_demo/c_action_button.dart';
import 'package:components_demo/interactive__yt_video_demo/card_component.dart';
import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'image_component.dart';

class CompHolder extends StatefulWidget {
  final SimpleComponent component;
  final YoutubePlayerController vController;
  const CompHolder(
    this.component, {
    required this.vController,
    super.key,
  });

  @override
  State<CompHolder> createState() => _CompHolderState();
}

class _CompHolderState extends State<CompHolder> {
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
        child: PointerInterceptor(child: ConstrainedBox(constraints: BoxConstraints.expand(), child: getCompView())),
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
                "Go To : ${widget.component.data}",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ),
            onClick: () {
              Duration? duration = DurationParser.fromHHMMSS(widget.component.data);
              if (duration != null) {
                widget.vController.seekTo(seconds: duration.inSeconds.toDouble(), allowSeekAhead: true);
              }
            });
      case CompType.question:
        return const CardComponent();
      default:
        return Card(
          margin: const EdgeInsets.all(3.0),
          child: Center(
            child: Text(
              widget.component.data,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        );
    }
  }
}
