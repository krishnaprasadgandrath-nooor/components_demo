import 'package:components_demo/interactive__yt_video_demo/question_component.dart';
import 'package:flutter/material.dart';

enum CardType { text, image, question, none }

enum Options { hyderabad, pune, mumbai }

class CardComponent extends StatefulWidget {
  final String data;
  const CardComponent({super.key, required this.data});

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  CardType cardType = CardType.none;
  Options option = Options.mumbai;
  TextStyle style = const TextStyle(fontSize: 12);
  Map<String, dynamic> questionsMap = {
    "2CRSZ62M": {
      "answer": "Chameleon",
      "options": ["Lizard", "Chameleon", "Rat"],
      "question": "Choose the  species name shown at 00:55:00 "
    },
    "GIF891K2": {
      "answer": "Phascolarctos cinereus",
      "options": ["Ailuropoda melanoleuca", "Ursus maritimus", "Phascolarctos cinereus"],
      "question": "Scientific name of Koala"
    }
  };
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Expanded(
          child: Card(
              elevation: 5,
              color: Colors.grey.shade300,
              child: QuestionWidget(
                  answer: questionsMap[widget.data]["answer"],
                  options: questionsMap[widget.data]["options"],
                  qId: widget.data,
                  question: questionsMap[widget.data]["question"])))
    ]);
  }
}
