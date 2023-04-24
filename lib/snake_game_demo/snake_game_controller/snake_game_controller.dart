import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/base_snake.dart';
import '../models/s_offset.dart';
import '../models/simple_snake.dart';
import '../models/util_data_models.dart';

import 'snake_game_controller_base.dart';

class SnakeController extends SnakeControllerBase {
  SnakeController({BaseSnake? snake, required Size stageSize, double unitSize = 20.0}) {
    _snake = snake ?? SimpleSnake(headPos: const SOffset(3, 4), unitSize: unitSize, stageSize: stageSize);
    _stageSize = stageSize;
    initTimer();
    spanFood();
  }

  ///Fields
  late final BaseSnake _snake;
  late final Size _stageSize;
  Timer? _updateTimer;
  SOffset? _foodPos;

  ///Getters
  @override
  BaseSnake get snake => _snake;

  @override
  Size get stageSize => _stageSize;

  @override
  Timer? get gameUpdater => _updateTimer;

  @override
  int get snakeLength => _snake.length;

  @override
  SOffset? get foodPos => _foodPos;

  @override
  void changeSnakeDirection(SDirection direction) => snake.changeDirection(direction);

  @override
  void moveSnake() {
    checkSnakeEating();
    snake.move();
  }

  @override
  void pause() {
    _updateTimer?.cancel();
    _updateTimer = null;
  }

  @override
  void restart() {
    _updateTimer?.cancel();
    _snake.reset();
    initTimer();
  }

  @override
  void resume() {
    initTimer();
  }

  @override
  void initTimer() {
    _updateTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      moveSnake();
      notifyListeners();
    });
  }

  @override
  void spanFood() {
    final x = Random().nextInt(stageSize.width.toInt()).toDouble();
    final y = Random().nextInt(stageSize.height.toInt()).toDouble();
    _foodPos = SOffset(x, y);
    notifyListeners();
  }

  @override
  void checkSnakeEating() {
    if (foodPos == null) return;
    if ((snake.headPosition.x - foodPos!.x).abs() < snake.unitSize &&
        (snake.headPosition.y - foodPos!.y).abs() < snake.unitSize) {
      snake.eat();
      _foodPos = null;
      Future.delayed(const Duration(milliseconds: 200), spanFood);
      notifyListeners();
    }
  }
}
