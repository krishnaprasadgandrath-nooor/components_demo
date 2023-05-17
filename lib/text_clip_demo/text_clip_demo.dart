import 'dart:async';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class TextClipDemoScreen extends StatefulWidget {
  const TextClipDemoScreen({super.key});

  @override
  State<TextClipDemoScreen> createState() => _TextClipDemoScreenState();
}

class _TextClipDemoScreenState extends State<TextClipDemoScreen> with SingleTickerProviderStateMixin {
  final duration = const Duration(seconds: 3);

  BlendMode blendMode = BlendMode.difference;
  late AnimationController controller = AnimationController(duration: duration, vsync: this);
  late Animation<Alignment> topLeftAnim = TweenSequence<Alignment>([
    TweenSequenceItem<Alignment>(tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
    TweenSequenceItem<Alignment>(tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
    TweenSequenceItem<Alignment>(tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
    TweenSequenceItem<Alignment>(tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
  ]).animate(controller);

  @override
  void initState() {
    super.initState();
    Timer.periodic(duration, (timer) {
      if (blendMode.index == BlendMode.values.length - 1) {
        blendMode = BlendMode.values[0];
      } else {
        blendMode = BlendMode.values[blendMode.index + 1];
      }
      setState(() {});
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Text Clip Screen", noLeading: true),
      backgroundColor: Colors.blueGrey[300],
      body: Center(
        child: Column(
          children: [
            Text(blendMode.name),
            SizedBox(
              height: 500,
              width: 500,
              child: AnimatedBuilder(
                animation: topLeftAnim,
                builder: (context, child) => ShaderMask(
                  blendMode: blendMode,
                  shaderCallback: (bounds) => LinearGradient(colors: [
                    Colors.red,
                    // Colors.red.withAlpha(200),
                    // Colors.red.withAlpha(150),
                    // Colors.red.withAlpha(100),
                    // Colors.red.withAlpha(50),
                    Colors.red.withAlpha(0)
                  ], begin: topLeftAnim.value, end: Alignment.center)
                      .createShader(bounds),
                  // ImageShader(
                  //   Image.network('https://cdn.pixabay.com/photo/2014/05/26/13/32/butterfly-354528_960_720.jpg').image,
                  //   TileMode.clamp,
                  //   TileMode.clamp,
                  // ),
                  child: SizedBox.expand(
                    child: Center(
                        child: Text(
                      'Shader MAsk Demo ${blendMode.name}',
                      style: const TextStyle(fontSize: 100.0, color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
