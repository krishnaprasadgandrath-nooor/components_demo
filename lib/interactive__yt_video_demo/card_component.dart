import 'package:components_demo/interactive__yt_video_demo/question_component.dart';
import 'package:flutter/material.dart';

enum CardType { text, image, question, none }

enum Options { hyderabad, pune, mumbai }

class CardComponent extends StatefulWidget {
  const CardComponent({super.key});

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {
  CardType cardType = CardType.none;
  Options option = Options.mumbai;
  TextStyle style = const TextStyle(fontSize: 12);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      // IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(Icons.close)),
      Expanded(
          child: Card(
              elevation: 5,
              color: Colors.grey.shade300,
              child: const QuestionWidget(
                  answer: "Chameleon",
                  options: ["Lizard", "Chameleon", "Rat"],
                  qId: "",
                  question: "Choose the  species name shown at 00:55:00 ")))
    ]);
  }
}
