import 'package:components_demo/binary_tree_problems/traingle_art_painter.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class TriangleArtScreen extends StatefulWidget {
  const TriangleArtScreen({super.key});

  @override
  State<TriangleArtScreen> createState() => _TriangleArtScreenState();
}

class _TriangleArtScreenState extends State<TriangleArtScreen> {
  int pointNum = 10;
  final Duration updateDur = const Duration(milliseconds: 50);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> progressiveDraw() async {
    if (pointNum > 80) return;
    pointNum++;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    progressiveDraw();
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Triangle Art Screen"),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: TriangleArtPainter(pointNum: pointNum),
              ),
            )),
      ),
    );
  }
}
