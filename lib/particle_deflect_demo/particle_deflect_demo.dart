import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'package:components_demo/utils/default_appbar.dart';

class ParticleDeflectDemo extends StatelessWidget {
  const ParticleDeflectDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Particle Deflect Demo"),
      body: SizedBox.expand(
        child: SceneBuilderWidget(
          builder: () => SceneController(
            back: ParticleDeflectScene(),
            config: SceneConfig.interactive,
          ),
        ),
      ),
    );
  }
}

class ParticleDeflectScene extends GSprite {
  List<Particle> particles = [];
  final double particleSize = 10.0;
  final double particleSpeed = 2.0;
  final double particleGap = 20.0;

  late GShape bg;
  late GSprite particleContainer;
  // late GSprite mouseRadius;
  // double particleSize

  double get stageWidth => stage!.stageWidth;
  double get stageHeight => stage!.stageHeight;
  @override
  void addedToStage() {
    super.addedToStage();
    mouseChildren = true;
    init();
    stage!.onResized.add(stageResized);
  }

  @override
  void update(double delta) {
    deflectNearbyParticles();
    moveParticles();
    drawParticles();

    // mouseRadius.graphics.clear().beginFill(Colors.white).drawCircle(mouseX, mouseY, 10.0).endFill();
    super.update(delta);
  }

  void init() {
    bg = GShape()..graphics.beginFill(Colors.black).drawRect(0, 0, stageWidth, stageHeight);
    particleContainer = GSprite();
    // mouseRadius = GSprite();
    addChild(bg);
    addChild(particleContainer);
    // addChild(mouseRadius);
  }

  void stageResized() {
    bg.graphics.clear();
    bg.graphics.beginFill(Colors.black).drawRect(0, 0, stageWidth, stageHeight).endFill();
    double col = 0, row = 0;
    particles.clear();
    while (col < stageHeight) {
      while (row < stageWidth) {
        final particle = Particle(
          x: row,
          y: col,
          color: Color.fromRGBO(255, ((col * row) % 255).toInt(), ((col * row) % 255).toInt(), 1),
        );
        particles.add(particle);
        row += (2 * particleSize) + particleGap;
      }
      row = 0;
      col += (2 * particleSize) + particleGap;
    }
  }

  double _distanceFast(double x1, double y1, double x2, double y2, double maxDistance) {
    final dx = (x2 - x1).abs();
    if (dx > maxDistance) {
      return maxDistance;
    }
    final dy = (y2 - y1).abs();
    if (dy > maxDistance) {
      return maxDistance;
    }
    return max(dx, dy);
  }

  void deflectNearbyParticles() {
    final mX = mouseX;
    final mY = mouseY;
    const maxDistane = 40.0;

    for (var element in particles) {
      final distance = _distanceFast(mX, mY, element.x, element.y, maxDistane);
      if (distance < maxDistane) {
        element.xSpeed = element.x > mX ? particleSpeed : -particleSpeed;
        element.ySpeed = element.y > mY ? particleSpeed : -particleSpeed;
      } else {
        if (element.x > element.ogX && element.xSpeed > 0) {
          element.xSpeed *= -1;
        }
        if (element.y > element.ogY && element.ySpeed >= 0) {
          element.ySpeed *= -1;
        }
        if (element.x < element.ogX && element.xSpeed < 0) {
          element.xSpeed *= -1;
        }
        if (element.y < element.ogY && element.ySpeed < 0) {
          element.ySpeed *= -1;
        }
        if (element.x == element.ogX) {
          element.xSpeed = 0;
        }
        if (element.y == element.ogY) {
          element.ySpeed = 0;
        }
      }
    }
  }

  void drawParticles() {
    particleContainer.children.clear();
    for (var element in particles) {
      final shape = GShape()
        ..graphics.beginFill(element.color).drawCircle(element.x, element.y, particleSize).endFill();
      particleContainer.addChild(shape);
    }
  }

  void moveParticles() {
    for (var element in particles) {
      element.x += element.xSpeed;
      element.y += element.ySpeed;
    }
  }
}

class Particle {
  double x;
  double y;
  Color color;
  double xSpeed;
  double ySpeed;

  bool isMoving = false;

  late double ogX;
  late double ogY;
  late Color ogColor;

  Particle({
    required this.x,
    required this.y,
    required this.color,
    this.xSpeed = 0,
    this.ySpeed = 0,
  }) {
    ogX = x;
    ogY = y;
    ogColor = color;
  }
}
