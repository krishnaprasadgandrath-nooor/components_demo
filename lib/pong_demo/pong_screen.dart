import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'package:components_demo/utils/default_appbar.dart';

class PongDemo extends StatefulWidget {
  const PongDemo({super.key});

  @override
  State<PongDemo> createState() => _PongDemoState();
}

class _PongDemoState extends State<PongDemo> {
  final Signal gameOverSignal = Signal();
  final EventSignal<int> livesSignal = EventSignal();
  final EventSignal<int> scoreSignal = EventSignal();
  bool isGameOver = false;
  int lives = 3;
  int score = 0;

  @override
  void initState() {
    super.initState();
    gameOverSignal.add(() {
      isGameOver = !isGameOver;
      setState(() {});
    });
    livesSignal.add((lives) {
      this.lives = lives;
      setState(() {});
    });
    scoreSignal.add((score) {
      if (this.score != score) {
        this.score = score;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Pong Demo"),
      body: Stack(
        children: [
          SizedBox.expand(
            child: IgnorePointer(
              ignoring: isGameOver,
              child: SceneBuilderWidget(
                builder: () => SceneController(
                  back: PongScene(
                    gameOverSignal: gameOverSignal,
                    livesSignal: livesSignal,
                    scoreSignal: scoreSignal,
                  ),
                  config: SceneConfig.games,
                ),
              ),
            ),
          ),
          if (isGameOver)
            const Center(
              child: Text(
                "Game Over",
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Text(
                    key: ValueKey(score),
                    "$score",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ...List.generate(
                    lives,
                    (index) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star,
                            color: Colors.red,
                          ),
                        ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PongScene extends GSprite {
  final Signal gameOverSignal;
  final EventSignal<int> livesSignal;
  final EventSignal<int> scoreSignal;
  final double pongSize = 10.0;
  final double reflectorWidth = 100.0;
  final bottomPadding = 10.0;
  PongScene({required this.gameOverSignal, required this.livesSignal, required this.scoreSignal});

  int lives = 3;
  int score = 0;

  bool isGameOver = false;

  late GShape reflector;
  late GShape pongShape;

  late final Pong pong = Pong(x: stageWidth / 2, y: stageHeight / 2, radius: pongSize, xSpeed: 2.0, ySpeed: 2.0);

  final tweenPos = 0.0.twn;

  ///Getters
  double get stageHeight => stage!.stageHeight;
  double get stageWidth => stage!.stageWidth;
  @override
  void addedToStage() {
    mouseChildren = true;
    init();
    onMouseMove.add(updateReflectorPos);
    super.addedToStage();
  }

  @override
  void update(double delta) {
    final t = getTimer() / 1000;
    if (!isGameOver) {
      movePong();
      updatePongPosition();
      scoreSignal.call(t.toInt());
    }
    super.update(delta);
  }

  void init() {
    graphics.beginFill(Colors.black).drawRect(0, 0, stageWidth, stageHeight).endFill();
    reflector = () {
      final shape1 = GShape();
      final grx1 = shape1.graphics;
      grx1.beginFill(Colors.white).drawRect(0 - reflectorWidth / 2, 0, reflectorWidth, pong.radius).endFill();
      shape1.x = stageWidth / 2;
      shape1.y = stageHeight - pongSize - bottomPadding;
      return shape1;
    }();

    pongShape = () {
      final shape = GShape();
      final grx = shape.graphics;
      grx.beginFill(Colors.red).drawCircle(0, 0, pong.radius).endFill();
      shape.x = stageWidth / 2;
      shape.y = stageHeight / 2;
      return shape;
    }();
    addChild(reflector);
    addChild(pongShape);
  }

  void movePong() {
    pong.x += pong.xSpeed;
    pong.y += pong.ySpeed;
    if (pong.x < 0) {
      pong.x = 0;
      pong.xSpeed *= -1;
    } else if (pong.x > stageWidth) {
      pong.x = stageWidth;
      pong.xSpeed *= -1;
    }
    if ((pong.y - reflector.y).abs() < pongSize / 2 && (pong.x < reflector.x + 50.0 && pong.x > reflector.x - 50.0)) {
      pong.ySpeed *= -1;
    }
    if (pong.y < 0) {
      pong.y = 0;
      pong.ySpeed *= -1;
    }
    if (pong.y > stageHeight) {
      pong.y = stageHeight;
      pong.ySpeed *= -1;
      lives--;
      if (lives >= 0) {
        livesSignal.dispatch(lives);
      } else {
        isGameOver = true;
        gameOverSignal.dispatch();
      }
    }
  }

  void updatePongPosition() {
    pongShape.x = pong.x;
    pongShape.y = pong.y;
  }

  void updateReflectorPos(MouseInputData event) {
    final dx = mouseX;
    if (dx + 50.0 < stageWidth) {
      final refPos = reflector.x;
      GTween.killTweensOf(this);
      tweenPos.tween(1.0,
          duration: 0.2,
          onUpdate: () {
            reflector.x = refPos * (1 - tweenPos.value) + dx * tweenPos.value;
          },
          onComplete: () => tweenPos.value = 0);
      // reflector.x = dx;
    }
  }
}

class Pong {
  double x;
  double y;
  double radius;
  double xSpeed;
  double ySpeed;
  Pong({
    required this.x,
    required this.y,
    required this.radius,
    required this.xSpeed,
    required this.ySpeed,
  });
}
