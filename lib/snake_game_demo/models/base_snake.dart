import 'package:flutter/services.dart';

// import '../snake_data_models.dart';
import 's_offset.dart';
import 'util_data_models.dart';

abstract class BaseSnake {
  SOffset get headPosition;
  SDirection get direction;
  int get length;
  double get unitSize;
  List<SOffset> get snakeBody;
  bool get hasJustEaten;
  Size get stageSize;

  void move();
  void eat();

  void changeDirection(SDirection direction);

  void reset({int length = 3, SOffset headPos = const SOffset(3, 4)});
}
