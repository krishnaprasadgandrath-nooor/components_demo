import 'package:components_demo/decoration_editor.dart/decoration_editing_controller.dart';
import 'package:components_demo/decoration_editor.dart/shadow_editor.dart';

import 'package:components_demo/decoration_editor.dart/shadow_editor_component.dart';
import 'package:flutter/material.dart';

import 'border_radius_editor.dart';
import 'custom_decorated_box.dart';
import 'fill_type_editor.dart';

class DecoreationEditorScreen extends StatefulWidget {
  const DecoreationEditorScreen({super.key});

  @override
  State<DecoreationEditorScreen> createState() => _DecoreationEditorScreenState();
}

class _DecoreationEditorScreenState extends State<DecoreationEditorScreen> {
  final DEditingController _controller = DEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decoration Editing Demo"),
      ),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: 300,
              height: 200,
              child: CustomDecoratedBox(
                _controller,
                child: const Center(
                    child: Text(
                  "Hello",
                  style: TextStyle(color: Colors.white),
                )),
                // child: DecoratedBox(
                //   decoration: BoxDecoration(
                //     color: _controller.color,
                //     gradient: _controller.gradient,
                //     shape: _controller.shape,
                //     borderRadius: _controller.borderRadius,
                //     boxShadow: _controller.shadows,
                //   ),
                //   child: SizedBox.expand(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: double.infinity,
              width: 200,
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(blurRadius: 2.0, spreadRadius: 2.0, color: Colors.grey, offset: Offset(-2, 0))
                ]),
                child: Column(
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
