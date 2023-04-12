import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class AnimatedBezierDemo extends StatelessWidget {
  const AnimatedBezierDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Animated Bezier Demo"),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 400,
          child: SceneBuilderWidget(
            builder: () => SceneController(
              config: SceneConfig.interactive,
              back: AnimatedBezierScene(),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBezierScene extends GSprite {
  final chartList = <List<double>>[
    [0.1, 0.2, 0.5, 0.25, 0.9],
    [0.3, 0.3, 0.65, 0.4, 0.2],
    [0.6, 0.4, 0.9, 0.25, 0.5],
    [0.5, 0.5, 0.15, 0.7, 0.4],
    [0.8, 0.6, 0.56, 0.9, 0.3],
  ];
  int index = 0;
  late var prevList = chartList[0];
  late var changingList = prevList;

  late GSprite bg, chart;

  var chartTween = 0.0.twn;

  //Getters
  double get stageWidth => stage!.stageWidth;
  double get stageHeight => stage!.stageHeight;

  @override
  void addedToStage() {
    initUI();
    super.addedToStage();
    onMouseClick.add(changeChart);
  }

  @override
  void update(double delta) {
    drawChart();
    super.update(delta);
  }

  void initUI() {
    bg = GSprite();
    final bGrx = bg.graphics;
    bGrx.beginFill(Colors.black).drawRect(0, 0, stageHeight, stageWidth);
    for (var i = 0; i < 5; i++) {
      bGrx.lineStyle(1.0, Colors.grey.withOpacity(0.2)).drawRect(stageWidth * (i / 5), 0, 1.0, stageHeight);
    }

    for (var i = 0; i < 10; i++) {
      bGrx.lineStyle(1.0, Colors.grey.withOpacity(0.2)).drawRect(0, stageHeight * (i / 10), stageWidth, 1.0);
    }

    chart = GSprite();
    drawChart();
    addChild(bg);
    addChild(chart);
  }

  void changeChart(MouseInputData event) {
    GTween.killTweensOf(this);
    index = index == 4 ? 0 : index + 1;
    chartTween.tween(
      1.0,
      duration: 3,
      onUpdate: updateTweenValue,
      onComplete: () {
        prevList = chartList[index];
        chartTween.value = 0;
      },
    );
  }

  void drawChart() {
    final chartGrx = chart.graphics;
    chartGrx.clear();
    for (var i = 0; i < 5; i++) {
      chartGrx.beginFill(Colors.red).drawCircle(stageWidth * (i / 5), stageHeight * (changingList[i]), 3.0).endFill();
    }

    chartGrx.lineStyle(2, Colors.red);
    for (var i = 0; i < 5; i++) {
      final point = Offset(stageWidth * (1 / i), stageHeight * changingList[i]);
      i == 0 ? chartGrx.moveTo(point.dx, point.dy) : chartGrx.lineTo(point.dx, point.dy);
    }

    chartGrx.endFill();
  }

  updateTweenValue() {
    final value = chartTween.value;
    final nextList = chartList[index];
    changingList = [];
    for (var i = 0; i < prevList.length; i++) {
      changingList.add(prevList[i] * (1 - value) + nextList[i] * value);
    }
    changingList;
  }
}
