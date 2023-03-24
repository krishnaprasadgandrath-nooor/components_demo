import 'package:flutter/material.dart';

class ActionEditor extends StatefulWidget {
  const ActionEditor({super.key});

  @override
  State<ActionEditor> createState() => _ActionEditorState();
}

class _ActionEditorState extends State<ActionEditor> {
  int _onTapAction = 1;
  int _onDisplayAction = 1;
  final onTapActionMap = <int, String>{
    1: "None",
    2: "link",
    3: "message",
    4: "video point",
  };
  final onDisplayActionMap = <int, String>{1: "none", 2: "pause Video"};
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
            constraints: BoxConstraints.loose(const Size(300, 400)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("On Click : "),
                Wrap(
                  direction: Axis.horizontal,
                  children: onTapActionMap.entries
                      .map((e) => RadioMenuButton(
                          value: e.key,
                          groupValue: _onTapAction,
                          onChanged: (value) => setState(() {
                                _onTapAction = value ?? _onTapAction;
                              }),
                          child: Text(e.value)))
                      .toList(),
                ),
                const Text("On display : "),
                Wrap(
                  direction: Axis.horizontal,
                  children: onDisplayActionMap.entries
                      .map((e) => RadioMenuButton(
                          value: e.key,
                          groupValue: _onDisplayAction,
                          onChanged: (value) => setState(() {
                                _onDisplayAction = value ?? _onDisplayAction;
                              }),
                          child: Text(e.value)))
                      .toList(),
                )
              ],
            ))
      ],
    );
  }
}
