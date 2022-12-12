import 'package:components_demo/rotating_card_demo/rotating_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RotatingCardScreen extends StatefulWidget {
  const RotatingCardScreen({super.key});

  @override
  State<RotatingCardScreen> createState() => _RotatingCardScreenState();
}

class _RotatingCardScreenState extends State<RotatingCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: RotatingCard(),
          )
        ],
      ),
    );
  }
}
