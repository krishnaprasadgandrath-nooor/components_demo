import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';
import 'package:tuple/tuple.dart';

typedef LinePoints = Tuple2<GPoint, GPoint>;

class RectIllusionHome extends StatefulWidget {
  static const name = "Rectangle Illustion Home";
  const RectIllusionHome({super.key});

  @override
  State<RectIllusionHome> createState() => _RectIllusionHomeState();
}

class _RectIllusionHomeState extends State<RectIllusionHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, RectIllusionHome.name),
      backgroundColor: Colors.black,
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 2)),
          child: SizedBox.square(
              dimension: 400.0,
              child: SceneBuilderWidget(
                builder: () => SceneController(back: RectSprite(), config: SceneConfig.static),
              )),
        ),
      ),
    );
  }
}

class RectSprite extends GSprite {
  final double size = 300.0;
  late final Size stageSize;
  late GRect baseRect;
  late GPoint firstPoint;

  late LinePoints lastLineTop;
  late LinePoints lastLineRight;
  late LinePoints lastLineBottom;
  late LinePoints lastLineLeft;

  // GPoint get topLeftCorner => baseRect.getPositions().first;
  // GPoint get topRightCorner => baseRect.getPositions()[1];
  // GPoint get bottomLeftCorner => baseRect.getPositions()[2];
  // GPoint get bottomRightCorner => baseRect.getPositions().last;

  @override
  void addedToStage() {
    stageSize = Size(stage!.stageWidth, stage!.stageHeight);
    drawFirstRect();
    // drawNextPoints();

    super.addedToStage();
  }

  void drawFirstRect() {
    double angle = 17;

    double variance = 0.01;

    double size = 400;
    final center = Offset(stageSize.width / 2, stageSize.height / 2);

    graphics.beginFill(Colors.transparent).lineStyle(2.0, Colors.red);
    while (size > 20) {
      final shape = GShape();
      shape.graphics
          .beginFill(Colors.transparent)
          .lineStyle(2.0, Colors.red)
          .drawRect((center.dx - size / 2) / 2, (center.dx - size / 2) / 2, size, size);
      shape.rotation = /* angle + */ variance;
      children.add(shape);
      size -= 20;
      variance += 0.022;
    }
  }
}
