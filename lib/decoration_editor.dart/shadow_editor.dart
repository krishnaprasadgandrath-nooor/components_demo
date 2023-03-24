import 'package:components_demo/decoration_editor.dart/shadow_editor_component.dart';
import 'package:flutter/material.dart';

import 'decoration_editing_controller.dart';

class ShadowEditor extends StatelessWidget {
  final DEditingController controller;
  const ShadowEditor(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: const BoxConstraints.expand(height: 30.0),
          alignment: Alignment.center,
          color: Colors.black26,
          child: const Text("Shadows :"),
        ),
        SizedBox(
          height: 30.0,
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  controller.addShadow(const BoxShadow());
                },
                icon: const Icon(Icons.add)),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200.0, minHeight: 50.0),
          child: ListView.builder(
            itemCount: controller.shadows.length,
            itemBuilder: (context, index) {
              final shadow = controller.shadows[index];
              return DShadowEditor(
                shadow,
                index: index,
                updateShadow: (value) => controller.updateShadow(index, value),
                deleteShadow: () => controller.removeShadow(index),
              );
            },
          ),
        )
      ],
    );
  }
}
