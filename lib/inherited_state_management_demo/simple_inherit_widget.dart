import 'package:components_demo/inherited_state_management_demo/simple_state.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SimplInheritedWidget extends InheritedWidget {
  final SimpleState simplState;

  const SimplInheritedWidget({super.key, required this.simplState, required super.child});

  static SimplInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SimplInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant SimplInheritedWidget oldWidget) {
    return oldWidget.simplState != simplState;
  }
}
