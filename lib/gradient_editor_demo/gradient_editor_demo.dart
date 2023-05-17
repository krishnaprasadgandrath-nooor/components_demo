import 'package:flutter/material.dart';
import '../decoration_editor.dart/gradient_editor.dart';

class GradientEditorScreen extends StatefulWidget {
  const GradientEditorScreen({super.key});

  @override
  State<GradientEditorScreen> createState() => _GradientEditorScreenState();
}

class _GradientEditorScreenState extends State<GradientEditorScreen> {
  Gradient _gradient = const LinearGradient(colors: [Colors.black, Colors.white]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints.expand(height: 200, width: 200),
              decoration: BoxDecoration(gradient: _gradient),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 350,
              width: double.infinity,
              child: GradientEditor(
                _gradient,
                updateGradient: (gradient) {
                  _gradient = gradient;
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
