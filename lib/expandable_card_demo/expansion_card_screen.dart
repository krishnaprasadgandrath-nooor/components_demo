// expansion_tile_demo.dart

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

import 'expandable_card.dart';

class ExpandableCardScreen extends StatefulWidget {
  const ExpandableCardScreen({super.key});

  @override
  State<ExpandableCardScreen> createState() => _ExpandableCardScreenState();
}

class _ExpandableCardScreenState extends State<ExpandableCardScreen> {
  // double _width = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _width = 200;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Expandable Card Demo"),
      body: Column(children: [
        ExpandableCard(
            title: "Tabs",
            children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                .map((e) => Container(
                      height: e * 30,
                      color: Colors.accents[e],
                    ))
                .toList()),
        const ExpansionTile(title: Text("Hello")),
      ]),
    );
  }
}
