import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'package:components_demo/utils/default_appbar.dart';

class GraphxFunDemo extends StatelessWidget {
  const GraphxFunDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final Signal scaleSignal = Signal();
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Grpahx Fun Demo"),
      body: Stack(children: [
        Center(
          child: ClipRect(
            clipBehavior: Clip.none,
            child: ColoredBox(
                color: Colors.grey.shade200,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: SceneBuilderWidget(
                    autoSize: true,
                    builder: () => SceneController(
                        back: FunSprite(
                      scaleSignal: scaleSignal,
                    )),
                  ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              IconButton(onPressed: () => scaleSignal.dispatch(), icon: const Icon(Icons.scale)),
            ],
          ),
        )
      ]),
    );
  }
}

class FunSprite extends GSprite {
  FunSprite({
    required this.scaleSignal,
  });

  final Signal scaleSignal;
  late GShape gradTriangle;
  late GSprite facesSprite;
  late GShape scalingCircle;

  double get sH => stage!.stageHeight;
  double get sW => stage!.stageWidth;
  @override
  void addedToStage() {
    _init();
    scaleSignal.add(scaleTriangle);
    super.addedToStage();
  }

  @override
  void dispose() {
    GTween.killTweensOf(this);
    super.dispose();
  }

  @override
  void update(double delta) {
    final t = getTimer() / 10;
    final sinValue = Math.sin(deg2rad(t));
    // trace(sinValue);
    gradTriangle.rotation = -sinValue;
    scalingCircle.scale = 1;
    scalingCircle.scale = 0.25 + Math.sin(-deg2rad(t));
    // if ((sinValue * 10).toInt() == 8) {
    //   gradTriangle.twn = gradTriangle.tween(duration: 100, scale: gradTriangle.scale != 1 ? 1 : 0.3);
    // }
    super.update(delta);
  }

  void _init() {
    //gradient Triangle
    gradTriangle = GShape();
    final grx = gradTriangle.graphics;
    grx.beginGradientFill(GradientType.linear, [Colors.greenAccent, Colors.blueAccent], ratios: [0, 1]);
    grx.drawPolygonFaces(-0, 0, sH, 3);
    gradTriangle.x = sH / 2;
    gradTriangle.y = sW / 2;

    scalingCircle = () {
      GShape shape = GShape();
      final grx = shape.graphics;
      grx
        ..beginFill(const Color(0xffF66868))
        ..drawCircle(0, 0, 30.0);
      shape.setPosition(sW / 2, sH / 2);
      return shape;
    }();

    ///faces
    final GShape face = () {
      final shape = GShape();
      final fGfx = shape.graphics;
      //head
      fGfx
        ..lineStyle(8.0, const Color(0xff949F16))
        ..beginFill(const Color(0xffFFEA4D))
        ..drawCircle(0, 0, 100).endFill();
      //eyes
      fGfx
        ..beginFill(Colors.black)
        ..drawEllipse(-40, -15, 8, 16)
        ..drawEllipse(40, -15, 8, 16)
        ..endFill();
      //mouth
      fGfx
        ..lineStyle(4, Colors.black)
        ..beginFill(Colors.black)
        ..moveTo(-30, 40)
        ..lineTo(30, 40)
        ..endFill();
      return shape;
    }();

    final GShape happyFace = () {
      final shape = GShape();
      final fGfx = shape.graphics;
      //head
      fGfx
        ..lineStyle(8.0, const Color(0xffBA6335))
        ..beginFill(const Color(0xffEE894A))
        ..drawCircle(0, 0, 80).endFill();
      //eyes
      fGfx
        ..beginFill(Colors.black)
        ..drawCircle(-40, -15, 10)
        ..drawCircle(40, -15, 10)
        ..endFill();
      //mouth
      fGfx
        ..lineStyle(8.0, Colors.black, true, StrokeCap.round)
        ..arc(0, 10, 40.0, deg2rad(45), deg2rad(90))
        ..endFill();

      shape.setPosition(-150, 0);
      return shape;
    }();

    final GShape sadFace = () {
      final shape = GShape();
      final fGfx = shape.graphics;
      //head
      fGfx
        ..lineStyle(8.0, const Color(0xff239423))
        ..beginFill(const Color(0xff8FB561))
        ..drawCircle(0, 0, 60).endFill();
      //eyes
      fGfx
        ..beginFill(Colors.black)
        ..drawEllipse(-30, -10, 4, 12)
        ..drawEllipse(30, -10, 4, 12)
        ..endFill();
      //mouth
      fGfx
        ..lineStyle(4.0, Colors.black, true, StrokeCap.round)
        ..arc(0, 50, 30.0, deg2rad(225), deg2rad(90))
        ..endFill();

      shape.setPosition(150, 0);
      return shape;
    }();

    facesSprite = GSprite()
      ..setPosition(sW / 2, sH / 2)
      ..addChild(sadFace)
      ..addChild(face)
      ..addChild(happyFace);

    addChild(gradTriangle);
    addChild(facesSprite);
    addChild(scalingCircle);
  }

  void scaleTriangle() {
    GTween.killTweensOf(gradTriangle);
    gradTriangle.tween(duration: 1, scale: 0.5, onComplete: () => gradTriangle.tween(duration: 1, delay: 3, scale: 1));
  }
}
