import 'package:components_demo/decoration_editor.dart/d_editor_utils.dart';
import 'package:components_demo/decoration_editor.dart/decoration_editing_controller.dart';
import 'package:components_demo/decoration_editor.dart/decoration_enums.dart';
import 'package:flutter/material.dart';

import 'gradient_editor.dart';

class FillTypeEditor extends StatefulWidget {
  final DEditingController controller;
  const FillTypeEditor(this.controller, {super.key});

  @override
  State<FillTypeEditor> createState() => _FillTypeEditorState();
}

class _FillTypeEditorState extends State<FillTypeEditor> {
  List<Color> _gradientColor = [];
  List<double> _gradientStops = [];
  DGradType _gradType = DGradType.linear;

  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints.expand(height: 30.0),
          color: Colors.black26,
          alignment: Alignment.center,
          child: const Text("Fill Editor"),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: DropdownButton(
            value: widget.controller.fillType,
            items: DFillType.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              widget.controller.fillType = value;
            },
          ),
        ),
        if (widget.controller.fillType == DFillType.solid)
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 30.0, maxHeight: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    final color = await DEditorUtils.showColorPicker(context, color: widget.controller.color);

                    widget.controller.update(color: color);
                  },
                  child: ColoredBox(
                    color: widget.controller.color ?? Colors.grey,
                    child: const SizedBox(height: 30.0, width: 100.0),
                  ),
                ),
              ],
            ),
          ),
        if (widget.controller.fillType == DFillType.gradient)
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 30.0, maxHeight: 350.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GradientEditor(
                  widget.controller.gradient!,
                  updateGradient: (value) => widget.controller.update(gradient: value),
                )
              ],
            ),
          )
      ],
    );
  }

  void addGradientColor() {}
}
