import 'package:components_demo/decoration_editor.dart/decoration_editing_controller.dart';
import 'package:flutter/material.dart';

class CustomDecoratedBox extends StatefulWidget {
  final DEditingController controller;
  final Widget? child;
  const CustomDecoratedBox(
    this.controller, {
    super.key,
    this.child,
  });

  @override
  State<CustomDecoratedBox> createState() => _CustomDecoratedBoxState();
}

class _CustomDecoratedBoxState extends State<CustomDecoratedBox> {
  late final controller = widget.controller;

  @override
  void initState() {
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: controller.color,
        borderRadius: controller.borderRadius,
        shape: controller.shape,
        gradient: controller.gradient,
        boxShadow: controller.shadows,
      ),
      child: widget.child,
    );
  }
}
