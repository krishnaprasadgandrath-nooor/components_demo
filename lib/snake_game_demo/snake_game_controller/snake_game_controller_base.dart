import 'dart:async';

import 'package:components_demo/snake_game_demo/models/s_offset.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/base_snake.dart';
import '../models/util_data_models.dart';

abstract class SnakeControllerBase extends ChangeNotifier {
  ///Required Fields in sub classes
  BaseSnake get snake;
  Size get stageSize;
  Timer? get gameUpdater;
  int get snakeLength;
  SOffset? get foodPos;

  ///Required methods in sub classes
  void moveSnake();
  void changeSnakeDirection(SDirection direction);
  void pause();
  void resume();
  void restart();
  void initTimer();
  void spanFood();
  void checkSnakeEating();

  @override
  void dispose() {
    gameUpdater?.cancel();
    super.dispose();
  }
}
