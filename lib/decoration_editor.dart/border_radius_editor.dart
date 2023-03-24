import 'package:components_demo/decoration_editor.dart/decoration_editing_controller.dart';
import 'package:components_demo/number_input.dart';
import 'package:flutter/material.dart';

class BorderRadiusEditor extends StatefulWidget {
  final DEditingController controller;
  const BorderRadiusEditor(
    this.controller, {
    super.key,
  });

  @override
  State<BorderRadiusEditor> createState() => _BorderRadiusEditorState();
}

class _BorderRadiusEditorState extends State<BorderRadiusEditor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints.expand(height: 30.0),
          color: Colors.black26,
          alignment: Alignment.center,
          child: const Text("Radius Editor"),
        ),
        SizedBox(
          height: 30.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 30.0,
                child: CheckboxListTile(
                  value: widget.controller.allBorderRadius,
                  onChanged: (value) {
                    if (value != null) widget.controller.changeAllBorderRadius(value);
                  },
                ),
              ),
              const Text("All")
            ],
          ),
        ),
        if (widget.controller.allBorderRadius)
          SizedBox(
            height: 80.0,
            width: 80.0,
            child: Center(
              child: NumberInput(
                label: "Radius",
                initialValue: widget.controller.borderRadius?.bottomLeft.x ?? 0.0,
                onChanged: (value) {
                  widget.controller.updateBorderRadius(BorderRadius.all(Radius.circular(value)));
                },
              ),
            ),
          )
        else
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 80.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 80,
                        child: NumberInput(
                          label: "Top Left",
                          initialValue: widget.controller.borderRadius?.topLeft.x ?? 0.0,
                          onChanged: (value) {
                            widget.controller.updateBorderRadius(
                                widget.controller.borderRadius!.copyWith(topLeft: Radius.circular(value)));
                          },
                        )),
                    SizedBox(
                        width: 80,
                        child: NumberInput(
                          label: "Top Right",
                          initialValue: widget.controller.borderRadius?.topRight.x ?? 0.0,
                          onChanged: (value) {
                            widget.controller.updateBorderRadius(
                                widget.controller.borderRadius!.copyWith(topRight: Radius.circular(value)));
                          },
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 85.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: 80,
                        child: NumberInput(
                          label: "Bottom Left",
                          initialValue: widget.controller.borderRadius?.bottomLeft.x ?? 0.0,
                          onChanged: (value) {
                            widget.controller.updateBorderRadius(
                                widget.controller.borderRadius!.copyWith(bottomLeft: Radius.circular(value)));
                          },
                        )),
                    SizedBox(
                        width: 80,
                        child: NumberInput(
                          label: "Bottom Right",
                          initialValue: widget.controller.borderRadius?.bottomRight.x ?? 0.0,
                          onChanged: (value) {
                            widget.controller.updateBorderRadius(
                                widget.controller.borderRadius!.copyWith(bottomRight: Radius.circular(value)));
                          },
                        )),
                  ],
                ),
              )
            ],
          )
      ],
    );
  }
}
