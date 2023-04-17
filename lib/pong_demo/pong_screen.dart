import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:uuid/uuid.dart';

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
    updateGameOver();
    updateLives();
    incrementScore();
  }

  void updateGameOver() {
    gameOverSignal.add(() {
      isGameOver = !isGameOver;
      setState(() {});
    });
  }

  void updateLives() {
    livesSignal.add((lives) {
      this.lives = lives;
      setState(() {});
    });
  }

  void incrementScore() {
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
  final brickWidth = 100.0;
  final brickHeight = 20.0;
  PongScene({required this.gameOverSignal, required this.livesSignal, required this.scoreSignal});

  int lives = 3;
  int score = 0;

  bool isGameOver = false;

  late GShape reflector;
  late GShape pongShape;
  late GSprite bricksContainer;
  late GSprite collapsedBricksContainer;
  List<Brick> bricks = [];
  List<Brick> collapsedBricks = [];

  late final Pong pong = Pong(x: stageWidth / 2, y: stageHeight / 2, radius: pongSize, xSpeed: 2.0, ySpeed: 2.0);

  final tweenPos = 0.0.twn;
  final collideTwn = 0.0.twn;

  ///Getters
  double get stageHeight => stage!.stageHeight;
  double get stageWidth => stage!.stageWidth;
  @override
  void addedToStage() {
    mouseChildren = true;
    initUI();
    onMouseMove.add(updateReflectorPos);
    super.addedToStage();
  }

  @override
  void update(double delta) {
    final t = getTimer() / 1000;
    if (!isGameOver) {
      movePong();
      updatePongPosition();
      checkPongCollisionAndDrawBricks();
      if (collapsedBricks.isNotEmpty) {
        drawCollpsedBricks();
      }
    }
    super.update(delta);
  }

  void initUI() {
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

    bricksContainer = GSprite();
    bool add = false;
    for (double y = brickHeight / 2; y < stageHeight / 3; y += brickHeight + 3) {
      for (double x = brickWidth / 2; x < stageWidth; x += brickWidth + 3) {
        if (add == false) {
          add = true;
          continue;
        }
        add = false;
        final brick = Brick(
            x: x,
            y: y,
            color: Colors.accents[bricks.length % Colors.accents.length],
            height: brickHeight,
            width: brickWidth);
        bricks.add(brick);
        bricksContainer.addChild(brick.shape);
      }
      add = !add;
    }
    addChild(bricksContainer);

    collapsedBricksContainer = GSprite();
    addChild(collapsedBricksContainer);
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
    if ((pong.y - reflector.y).abs() < pongSize / 2 && (pong.x - reflector.x).abs() < 50.0) {
      pong.ySpeed > 0 ? pong.ySpeed *= -1 : null;
    }
    if (pong.y < 0 + pongSize / 2) {
      pong.y = pongSize / 2;
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

  void checkPongCollisionAndDrawBricks() {
    int collidedIndex = -1;
    Brick? goneBrick;
    for (var i = 0; i < bricks.length; i++) {
      final brick = bricks[i];
      bool collided = brick.checkPongCollision(pong.x, pong.y, pongSize / 2);
      if (collided) {
        collidedIndex = i;
        goneBrick = brick;
        break;
      }
    }
    if (collidedIndex > 0) {
      pong.ySpeed *= -1;
      scoreSignal.call(score++);
      bricks.removeAt(collidedIndex);
      bricksContainer.children.removeAt(collidedIndex);
      if (goneBrick != null) collapsedBricks.add(goneBrick);
      startBricksTween();
    }
  }

  void startBricksTween() {
    collideTwn.tween(1, duration: 1, onUpdate: () {
      for (var i = 0; i < collapsedBricks.length; i++) {
        collapsedBricks[i].y = collapsedBricks[i].y + 2;
        collapsedBricks[i].color = collapsedBricks[i].color.withOpacity(1 - collideTwn.value);
      }
    }, onComplete: () {
      collideTwn.value = 0;
      collapsedBricks.clear();
      collapsedBricksContainer.children.clear();
      collapsedBricksContainer.graphics.clear();
    });
  }

  void redrawBricks() {
    bricksContainer.graphics.clear();
    for (var i = 0; i < bricks.length; i++) {
      bricksContainer.addChild(bricks[i].shape);
    }
  }

  void drawCollpsedBricks() {
    collapsedBricksContainer.children.clear();
    for (var i = 0; i < collapsedBricks.length; i++) {
      collapsedBricksContainer.addChild(collapsedBricks[i].shape);
    }
  }
}

class Brick {
  late String id;
  double x;
  double y;
  Color color;
  double height;
  double width;
  Brick({
    required this.x,
    required this.y,
    required this.color,
    required this.height,
    required this.width,
  }) {
    id = const Uuid().v1();
  }

  GShape get shape => GShape()
    ..graphics.beginFill(color).drawRect(x - width / 2, y - height / 2, width, height).endFill()
    ..userData = id;

  bool checkPongCollision(double ballX, double ballY, double radius) {
    if ((ballY - y).abs() > (radius + height / 2)) return false;
    if ((ballX - x).abs() > (width / 2)) return false;
    if ((ballX - x).abs() < (radius + width / 2) && (ballY - y).abs() < (radius + height / 2)) return true;
    return false;
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
