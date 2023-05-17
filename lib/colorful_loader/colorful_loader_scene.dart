import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class ColorfulLoaderScene extends GSprite {
  late BubblePreloader loader;

  @override
  void addedToStage() {
    // we dont need touch interaction in this scene.
    mouseChildren = false;
    mouseEnabled = false;

    loader = BubblePreloader(w: 385, h: 14);
    addChild(loader);
    stage!.onResized.add(_handleStageResize);
  }

  void _handleStageResize() {
    loader.x = (stage!.stageWidth - loader.w) / 2;
    loader.y = (stage!.stageHeight - loader.h) / 2;
  }
}

class BubblePreloader extends GSprite {
  static const gradientColors = <Color>[
    Color(0xFF9874D3),
    Color(0xFF6E7CCC),
    Color(0xFF56BFCA),
    Color(0xFF9874D3),
    Color(0xFF6E7CCC),
    Color(0xFF56BFCA),
  ];

  double w, h;
  GShape? bg, percentMask, bgGradient;
  late GSprite percentContainer, bubblesContainer;
  double borderRadius = 0.0, percent = 0.25, gradientShift = 0.0;
  Color bgColor = const Color(0xffDEE0E3);
  int numBubbles = 50;

  final _twnPrcnt = 0.0.twn;

  BubblePreloader({this.w = 200, this.h = 80}) {
    borderRadius = h / 2;
    onAddedToStage.addOnce(_initUi);
  }

  void _initUi() {
    bg = GShape();

    percentContainer = GSprite();
    bubblesContainer = GSprite();

    bgGradient = GShape();
    percentMask = GShape();

    percentContainer.addChild(bgGradient!);
    percentContainer.addChild(bubblesContainer);

    addChild(bg!);
    addChild(percentContainer);
    addChild(percentMask!);
    percentContainer.mask = percentMask;

    _drawBack();
    _buildBubbles();

    _tweenpercent();
  }

  void _tweenpercent() {
    _twnPrcnt.value = percent;

    ///Toggles percent between 1,0,1,0,1,0,1....
    var target = percent < 1 ? 1 : 0;
    _twnPrcnt.tween(
      target,
      duration: 2,
      onUpdate: () {
        percent = _twnPrcnt.value;
        _drawMask();
      },
      onComplete: _tweenpercent,
    );
  }

  void _buildBubbles() {
    _drawGradient();
    List.generate(numBubbles, (index) {
      final bubble = GShape();
      bubble.graphics.beginFill(kColorWhite.withOpacity(.4)).drawCircle(0, 0, 4).endFill();
      bubble.x = Math.randomRange(0, w);
      bubble.y = Math.randomRange(-10, h + 10);
      if (Math.randomBool()) {
        var blur = Math.randomRange(1, 2);
        bubble.filters = [GBlurFilter(blur, blur), GlowFilter(2.0, 2.0, const Color.fromARGB(255, 255, 255, 255))];
      }
      bubblesContainer.addChild(bubble);
    });
  }

  @override
  void update(double delta) {
    super.update(delta);
    gradientShift += .04;
    _drawGradient();
    _moveBubbles();
    _drawMask();
  }

  void _drawMask() {
    percentMask!.graphics.clear().beginFill(bgColor).drawRoundRect(0, 0, w * percent, h, borderRadius).endFill();
  }

  void _moveBubbles() {
    for (var i = 0; i < numBubbles; ++i) {
      final bubble = bubblesContainer.getChildAt(i) as GShape;
      bubble.y -= 0.3 * bubble.scale;
      if (bubble.y < -10) {
        bubble.y = h + 10;
      }
    }
  }

  void _drawBack() {
    bg!.graphics.beginFill(bgColor).drawRoundRect(0, 0, w, h, borderRadius).endFill();
    _drawGradient();
  }

  void _drawGradient() {
    gradientShift %= 3;
    var a1 = -1.0 - gradientShift;
    var a2 = 4.0 - gradientShift;
    bgGradient!.graphics
        .clear()
        .beginGradientFill(
          GradientType.linear,
          gradientColors,
          begin: Alignment(a1, 0),
          end: Alignment(a2, 0),
        )
        .drawRoundRect(0, 0, w, h, borderRadius)
        .endFill();
  }
}
