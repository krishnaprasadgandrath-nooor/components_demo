import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CounterStateVariant extends InheritedWidget {
  int count = 0;
  CounterStateVariant({
    super.key,
    required super.child,
  });

  static CounterStateVariant? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CounterStateVariant>());
  }

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  @override
  bool updateShouldNotify(covariant CounterStateVariant oldWidget) {
    return count != oldWidget.count;
  }
}
