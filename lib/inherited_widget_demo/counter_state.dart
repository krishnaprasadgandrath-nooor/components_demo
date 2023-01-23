import 'dart:developer';

import 'package:flutter/material.dart';

class CounterState extends InheritedWidget {
  final int count;

  final Function increment;
  final Function decrement;
  const CounterState({
    super.key,
    required this.count,
    required this.increment,
    required this.decrement,
    required super.child,
  });

  static CounterState? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CounterState>());
  }

  @override
  bool updateShouldNotify(covariant CounterState oldWidget) {
    return count != oldWidget.count;
  }
}
