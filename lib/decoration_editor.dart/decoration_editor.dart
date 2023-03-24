import 'package:components_demo/decoration_editor.dart/decoration_editing_controller.dart';
import 'package:components_demo/decoration_editor.dart/shadow_editor.dart';
import 'package:flutter/material.dart';

import 'border_radius_editor.dart';
import 'decoration_editor_screen.dart';
import 'fill_type_editor.dart';

class DecorationEditor extends StatelessWidget {
  final DEditingController _controller;
  const DecorationEditor(this._controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FillTypeEditor(_controller),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: const BoxConstraints.expand(height: 30.0),
              alignment: Alignment.center,
              color: Colors.black26,
              child: const Text("Shape"),
            ),
            DropdownButton(
              value: _controller.shape,
              items: BoxShape.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
              onChanged: (value) {
                if (value != null) _controller.update(shape: value);
              },
            )
          ],
        ),
        if (_controller.shape != BoxShape.circle) BorderRadiusEditor(_controller),
        ShadowEditor(_controller),
      ],
    );
  }
}
