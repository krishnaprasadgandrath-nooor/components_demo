import 'package:components_demo/filp_card_demo/flip_card.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class FlipCardScreen extends StatefulWidget {
  const FlipCardScreen({super.key});

  @override
  State<FlipCardScreen> createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Flip Card Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(3),
            child: FlipCard(
              front: Center(
                child: Card(
                    child: Container(
                        height: 200, width: 200, color: Colors.red, child: const Center(child: Text("Front")))),
              ),
              back: Center(
                child: Card(
                    child: Container(
                        height: 200, width: 200, color: Colors.green, child: const Center(child: Text("Back")))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
