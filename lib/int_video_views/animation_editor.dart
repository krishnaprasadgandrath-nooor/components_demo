import 'package:flutter/material.dart';

class AnimationEditor extends StatefulWidget {
  const AnimationEditor({super.key});

  @override
  State<AnimationEditor> createState() => _AnimationEditorState();
}

class _AnimationEditorState extends State<AnimationEditor> {
  int startAnimationType = 0;
  int endAnimationType = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints.expand(height: 30, width: 300),
            color: Colors.black12,
            child: const Text(" Start Animation")),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(300, 200)),
          child: DropdownButton(
            value: startAnimationType,
            items: List.generate(6, (index) => DropdownMenuItem(value: index, child: Text("Animation $index"))),
            onChanged: (value) => setState(() {
              startAnimationType = value ?? startAnimationType;
            }),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          constraints: const BoxConstraints.expand(height: 30, width: 300),
          color: Colors.black12,
          child: const Text(" End Animation"),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(300, 200)),
          child: DropdownButton(
            items: List.generate(6, (index) => DropdownMenuItem(value: index, child: Text("Animation $index"))),
            onChanged: (value) => setState(() {
              endAnimationType = value ?? endAnimationType;
            }),
            value: endAnimationType,
          ),
        ),
      ],
    );
  }
}
