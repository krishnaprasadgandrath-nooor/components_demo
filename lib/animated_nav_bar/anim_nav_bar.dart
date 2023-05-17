import 'package:flutter/material.dart';

class AnimatedBottomNavBar extends StatefulWidget {
  const AnimatedBottomNavBar({super.key});

  @override
  State<AnimatedBottomNavBar> createState() => AnimatedBottomNavBarState();
}

class AnimatedBottomNavBarState extends State<AnimatedBottomNavBar> with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 500);
  // late final AnimationController _animationController = AnimationController(vsync: this, duration: _duration, value: 0);
  bool _isExpanded = false;

  @override
  void dispose() {
    // _animationController.stop();
    // _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 88.0,
            width: 40.0,
            child: TapRegion(
              onTapOutside: (event) {
                if (_isExpanded) _toggleExpansion();
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 235, 115, 115), borderRadius: BorderRadius.circular(30.0)),
                child: AnimatedSize(
                  duration: _duration,
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      if (!_isExpanded)
                        IconButton(color: Colors.white, onPressed: _toggleExpansion, icon: const Icon(Icons.add))
                      else
                        ...[Icons.photo, Icons.audio_file, Icons.video_call]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: DecoratedBox(
                                      decoration:
                                          BoxDecoration(color: Colors.white.withAlpha(50), shape: BoxShape.circle),
                                      child: InkWell(
                                          onTap: () {},
                                          child: Center(
                                            heightFactor: 2.0,
                                            widthFactor: 2.0,
                                            child: Icon(e, color: Colors.white),
                                          ))),
                                ))
                            .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: const MiddlecutShape(clipSize: 50.0),
            child: SizedBox(
              height: 100.0,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...[Icons.home, Icons.settings]
                      .map((e) => IconButton(color: const Color(0xffFECACA), onPressed: () {}, icon: Icon(e)))
                      .toList()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _toggleExpansion() {
    _isExpanded = !_isExpanded;
    toggleAnimation();
    setState(() {});
  }

  Future<void> toggleAnimation() async {
    //   if (_animationController.value < 1) {
    //     await _animationController.forward();
    //   } else {
    //     await _animationController.reverse();
    //   }
  }
}

class MiddlecutShape extends ShapeBorder {
  final double clipSize;
  final double borderRadius;
  const MiddlecutShape({
    this.clipSize = 40.0,
    this.borderRadius = 5.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return defaultPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return defaultPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // canvas.drawPath(defaultPath(rect), Paint());
  }

  @override
  ShapeBorder scale(double t) => MiddlecutShape(clipSize: clipSize * t, borderRadius: borderRadius * t);

  Path defaultPath(Rect rect) => Path()
    ..moveTo(rect.left + borderRadius, rect.top)
    ..lineTo((rect.width - clipSize) / 2, rect.top)
    ..arcToPoint(Offset((rect.width + clipSize) / 2, rect.top), clockwise: false, radius: Radius.circular(clipSize / 2))
    ..lineTo(rect.width / 2 + clipSize, rect.top)
    ..lineTo(rect.width - borderRadius, rect.top)
    ..quadraticBezierTo(rect.width, rect.top, rect.width, rect.top + borderRadius)
    ..lineTo(rect.width, rect.bottom - borderRadius)
    ..quadraticBezierTo(rect.width, rect.bottom, rect.width - borderRadius, rect.bottom)
    ..lineTo(rect.left + borderRadius, rect.bottom)
    ..quadraticBezierTo(rect.left, rect.bottom, rect.left, rect.bottom - borderRadius)
    ..lineTo(rect.left, borderRadius)
    ..quadraticBezierTo(rect.left, rect.top, rect.left + borderRadius, rect.top);
}
