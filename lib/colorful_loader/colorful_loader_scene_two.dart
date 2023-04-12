import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class ColorfulLoaderSceneTwo extends GSprite {
  static const bgColor = Color.fromARGB(255, 208, 208, 208);
  static const gradientColors = <Color>[
    Color(0xffD8BDBE),
    Color(0xffBD90E3),
    Color(0xffFD00D7),
    Color(0xffD31EE7),
    Color(0xffA03EE1),
    Color(0xff8633D3),
    Color(0xffA7449C),
    Color(0xffCC575F),
  ];
  final double w, h;
  late final double borderRadius;
  GShape? bg, percentageMask, gradFill;
  GSprite? percentContainer;

  final _twnPercentage = 0.0.twn;

  final int numBubbles = 70;

  double percent = 0, gradientShift = 0;

  ColorfulLoaderSceneTwo({
    this.w = 100,
    this.h = 20,
  }) {
    borderRadius = h / 2;
    onAddedToStage.addOnce(_initUi);
  }

  void _initUi() {
    bg = GShape();

    bg!.graphics.beginFill(bgColor).drawRoundRect(x, y, w, h, borderRadius).endFill();

    percentContainer = GSprite();
    gradFill = GShape()..userData = 'gradFill';

    gradFill!.graphics
        .beginGradientFill(GradientType.linear, gradientColors, begin: Alignment.centerLeft, end: Alignment.centerRight)
        .drawRoundRect(0, 0, w, h, borderRadius)
        .endFill();
    percentContainer!.addChildAt(gradFill!, 0);

    percentageMask = GShape();
    percentageMask!.graphics.beginFill(bgColor).drawRoundRect(0, 0, w / 2, h, borderRadius);

    ///Stage Children
    addChild(bg!);
    addChild(percentContainer!);
    addChild(percentageMask!);

    percentContainer!.mask = percentageMask!;
    buildBubbles();
    _startTween();
  }

  @override
  void update(double delta) {
    super.update(delta);
    _moveBubbles();
    _drawMask();
    gradientShift += 0.04;
    _drawGradient();
  }

  void buildBubbles() {
    List.generate(numBubbles, (index) {
      final bubble = GShape();
      bubble.graphics.beginFill(const Color(0xffffffff).withOpacity(0.4)).drawCircle(0, 0, 4).endFill();
      bubble.x = Math.randomRange(0, w);
      bubble.y = Math.randomRange(-10, h + 10);
      if (Math.randomBool()) {
        var blur = Math.randomRange(1, 2);
        bubble.filters = [GBlurFilter(blur, blur)];
      }
      percentContainer!.addChild(bubble);
    });
  }

  void _moveBubbles() {
    for (var i = 0; i < numBubbles; i++) {
      final GShape bubble = percentContainer!.getChildAt(i);
      //skipping gradient shape
      if (bubble.userData != null && (bubble.userData as String).compareTo('gradFill') == 0) continue;
      bubble.y -= 0.4;
      if (bubble.y < 0) {
        bubble.y = h + 10;
      }
    }
  }

  void _startTween() {
    final percentage = _twnPercentage.value;
    final target = percentage < 1 ? 1 : 0;
    _twnPercentage.tween(
      target,
      duration: 2,
      onUpdate: () {
        percent = _twnPercentage.value;
      },
      onComplete: _startTween,
    );
  }

  void _drawMask() {
    percentageMask!.graphics
        .clear()
        .beginFill(bgColor)
        .drawRoundRect(0, 0, w * _twnPercentage.value, h, borderRadius)
        .endFill();
  }

  void _drawGradient() {
    gradientShift %= 3;
    final a1 = -1.0 - gradientShift;
    final a2 = 4.0 - gradientShift;
    gradFill!.graphics
        .clear()
        .beginGradientFill(GradientType.linear, gradientColors,
            begin: Alignment(a1, 0), end: Alignment(a2 - percent, 0))
        .drawRoundRect(0, 0, w, h, borderRadius)
        .endFill();
  }
}
