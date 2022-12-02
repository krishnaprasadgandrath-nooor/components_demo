import 'package:components_demo/rotaing_progress/rotating_progress.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class RotatingProgressScreen extends StatelessWidget {
  const RotatingProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Rotaring Progress Demo"),
      body: const Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: RotatingProgress(),
        ),
      ),
    );
  }
}
