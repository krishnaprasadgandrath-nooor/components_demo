// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'models/s_offset.dart';
import 'models/simple_snake.dart';
import 'models/util_data_models.dart';

void main(List<String> args) {
  SimpleSnake snakeOne =
      SimpleSnake(headPos: const SOffset(3, 4), direction: SDirection.right, stageSize: const Size(100, 100));
  print(snakeOne.snakeBody);
  snakeOne.move();
  print(snakeOne.snakeBody);
  snakeOne.changeDirection(SDirection.down);
  snakeOne.move();
  print(snakeOne.snakeBody);
}
