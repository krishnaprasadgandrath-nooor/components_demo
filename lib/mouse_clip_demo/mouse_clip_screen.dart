import 'dart:math';

import 'package:components_demo/connected_nodes_demo/connected_nodes_scene.dart';
import 'package:components_demo/filp_card_demo/flip_card_screen.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class MouseClipScreen extends StatelessWidget {
  const MouseClipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Mouse Clip Demo"),
      body: SizedBox.expand(
        child: SceneBuilderWidget(
          builder: () => SceneController(
            back: MouseClipSceneBuilder(),
            config: SceneConfig.interactive,
          ),
        ),
      ),
    );
  }
}

class MouseClipSceneBuilder extends GSprite {
  List<SimpleBall> balls = [];
  int numBalls = 300;

  GSprite? bg;
  GShape? frontClip;

  double get stageHeight => stage!.stageHeight;
  double get stageWidth => stage!.stageWidth;

  @override
  void addedToStage() {
    super.addedToStage();
    mouseChildren = true;
    _initUi();
  }

  double _distanceFast(double x1, double y1, double x2, double y2, final maxDistance) {
    final dx = (x2 - x1).abs();
    if (dx > maxDistance) {
      return maxDistance;
    }
    final dy = (y2 - y1).abs();
    if (dy > maxDistance) {
      return maxDistance;
    } else {
      return max(dx, dy);
    }
  }

  @override
  void update(double delta) {
    deflectCloserBalls();
    updateClipPosition();
    moveBalls();
    super.update(delta);
  }

  void _initUi() {
    for (var i = 0; i < numBalls; i++) {
      final ball = SimpleBall(width: stageWidth, height: stageHeight);
      balls.add(ball);
    }
    bg = GSprite();
    bg!.graphics.beginFill(Colors.black).drawRect(0, 0, stageWidth, stageHeight).endFill();
    frontClip = GShape();

    frontClip!.graphics
        .beginFill(Colors.transparent)
        .drawCircle(stageWidth / 2, stageHeight / 2, stageWidth / 8)
        .endFill();

    addChild(bg!);
    addChild(frontClip!);
    // bg!.mask = frontClip!;
  }

  void moveBalls() {
    bg!.children.clear();
    for (var ball in balls) {
      if (ball.x < 0) {
        ball.x = 0;
        ball.xSpeed *= -1;
      } else if (ball.x > stageWidth) {
        ball.x = stageWidth;
        ball.xSpeed *= -1;
      }

      if (ball.y < 0) {
        ball.y = 0;
        ball.ySpeed *= -1;
      } else if (ball.y > stageHeight) {
        ball.y = stageHeight;
        ball.ySpeed *= -1;
      }
      ball.x += ball.xSpeed;
      ball.y += ball.ySpeed;

      final shape = GShape();
      shape.graphics
          .beginFill(Colors.accents[ball.radius.toInt() % Colors.accents.length])
          .drawCircle(ball.x, ball.y, ball.radius)
          .endFill();

      bg!.addChild(shape);
    }
  }

  void updateClipPosition() {
    frontClip!.graphics.clear();
    frontClip!.x = mouseX;
    frontClip!.y = mouseY;
    frontClip!.graphics.beginFill(Colors.transparent).drawCircle(0, 0, stageHeight / 8).endFill();
  }

  void deflectCloserBalls() {
    const maxDistance = 60.0;
    final pX = mouseX;
    final pY = mouseY;
    for (var i = 0; i < balls.length; i++) {
      final ball = balls[i];
      final distance = _distanceFast(pX, pY, ball.x, ball.y, maxDistance);
      if (distance < maxDistance) {
        final nextPoint = Offset(ball.x + ball.xSpeed, ball.y + ball.ySpeed);
        final nextDistance = _distanceFast(pX, pY, nextPoint.dx, nextPoint.dy, maxDistance);
        if (nextDistance < distance) {
          ball.xSpeed *= -1;
          ball.ySpeed *= -1;
        }
      }
    }
  }
}
