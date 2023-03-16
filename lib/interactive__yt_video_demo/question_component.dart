import 'package:flutter/material.dart';

class QuestionWidget extends StatefulWidget {
  final String question;
  final String qId;
  final String answer;
  final List options;
  const QuestionWidget(
      {super.key, required this.question, required this.qId, required this.options, required this.answer});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      for (int i = 0; i < widget.options.length; i++)
        ListTile(
            title: Text(widget.options[i], style: const TextStyle(color: Colors.black)),
            leading: Radio(
                value: i,
                groupValue: selectedIndex,
                activeColor: widget.options[selectedIndex] == widget.answer ? Colors.blue : Colors.red,
                onChanged: (value) {
                  setState(() {
                    selectedIndex = value!;
                  });
                }))
    ]);
  }
}
