import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'package:components_demo/timeline_painter.dart';
import 'package:flutter/material.dart';

class TimeLineSlider extends StatefulWidget {
  final Duration duration;
  final Stream<Duration> positionStream;
  const TimeLineSlider({
    required this.duration,
    required this.positionStream,
    super.key,
  });

  @override
  State<TimeLineSlider> createState() => _TimeLineSliderState();
}

class _TimeLineSliderState extends State<TimeLineSlider> {
  late double timeLineLength = widget.duration.inSeconds * 100;
  late final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.positionStream,
      builder: (context, snapshot) {
        updateScrollOffset(snapshot);
        return Stack(alignment: Alignment.centerLeft, children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 30.0),
                SizedBox(
                  width: timeLineLength,
                  height: 30.0,
                  child: DecoratedBox(
                      decoration:
                          const BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: Colors.orange))),
                      child: ColoredBox(
                        color: Colors.black.withOpacity(0.2),
                        child: CustomPaint(
                          painter: TimelinePainter(),
                        ),
                      )),
                ),
              ],
            ),
          ),
          const Positioned(
              left: 30.0,
              width: 10.0,
              height: 30.0,
              child: VerticalDivider(
                color: Colors.black,
                width: 10.0,
                thickness: 1.0,
              )),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              snapshot.data?.toHHMMSS ?? "",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ]);
      },
    );
  }

  void updateScrollOffset(AsyncSnapshot<Duration> snapshot) {
    if (_scrollController.hasClients == false) return;
    double offset = (snapshot.data?.inMilliseconds ?? 0) / 10;
    if (offset > _scrollController.position.maxScrollExtent) return;
    _scrollController.jumpTo(snapshot.data!.inMilliseconds / 10);
  }
}



// double offset = 0;
// late final ScrollController _scrollController = ScrollController()
//   ..addListener(() {
//     final nextOffset = (_scrollController.offset / 200).toStringAsFixed(2);
//     if (nextOffset != offset.toStringAsFixed(2)) {
//       offset = (_scrollController.offset) / 100;
//       setState(() {});
//     }
//   });

// late final AnimationController _animationController =
//     AnimationController(vsync: this, lowerBound: 0, upperBound: 20000, duration: const Duration(seconds: 200))
//       ..addListener(() {
//         _scrollController.jumpTo(
//           _animationController.value,
//         );
//       });
