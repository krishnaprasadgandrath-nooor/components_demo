// ignore_for_file: avoid_print

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'base_snake.dart';
import 's_offset.dart';
import 'util_data_models.dart';

class SimpleSnake extends BaseSnake {
  SimpleSnake({
    required SOffset headPos,
    SDirection? direction,
    int length = 3,
    double unitSize = 5.0,
    required Size stageSize,
  }) {
    _direction = direction ?? _direction;
    _unitSize = unitSize;
    _stageSize = stageSize;
    initSnake(length, headPos);
  }

  void initSnake(int length, SOffset headPos) {
    _bodyParts = List.generate(length, (index) => SOffset.zero);
    _bodyParts[0] = headPos;
    final prevOffset = _direction.prevOffset;
    // print('prevOffset:${prevOffset}');
    for (var i = 1; i < length; i++) {
      _bodyParts[i] = headPos + (prevOffset * i * unitSize);
    }
    debugPrint("Hello");
  }

  ///Fields
  late List<SOffset> _bodyParts = [];
  late final double _unitSize;
  late final Size _stageSize;
  SDirection _direction = SDirection.right;
  bool _hasJustEaten = false;

  @override
  SOffset get headPosition => _bodyParts.first;

  @override
  List<SOffset> get snakeBody => UnmodifiableListView(_bodyParts);

  @override
  SDirection get direction => _direction;

  @override
  double get unitSize => _unitSize;

  @override
  Size get stageSize => _stageSize;

  @override
  bool get hasJustEaten => _hasJustEaten;

  @override
  void eat() {
    _hasJustEaten = true;
  }

  @override
  int get length => _bodyParts.length;

  @override
  void move() {
    SOffset prePartOff = _bodyParts.first.clone();

    ///Updating head
    _bodyParts[0] = _bodyParts[0] + (direction.nextOffset * unitSize);
    checkEdges();
    SOffset curOffset;

    ///Updating bodyParts
    for (int i = 1; i < length; i++) {
      curOffset = _bodyParts[i];
      _bodyParts[i] = prePartOff;
      prePartOff = curOffset;
    }
    if (_hasJustEaten) {
      _bodyParts.add(prePartOff.clone());
      _hasJustEaten = false;
    }
  }

  @override
  void changeDirection(SDirection direction) {
    if (_direction != direction && oppositeDirections[direction] != _direction) {
      _direction = direction;
    }
  }

  @override
  void reset({int length = 3, SOffset headPos = const SOffset(3, 4)}) {
    initSnake(length, headPos);
  }

  void checkEdges() {
    final headPos = _bodyParts.first;
    if (headPos.x < 0 || headPos.x > stageSize.width) {
      _bodyParts[0] = SOffset(headPos.x < 0 ? stageSize.width : 0, headPos.y);
    }
    if (headPos.y < 0 || headPos.y > stageSize.height) {
      _bodyParts[0] = SOffset(headPos.x, headPos.y < 0 ? stageSize.height : 0);
    }
  }
}
