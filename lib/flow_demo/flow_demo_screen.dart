import 'dart:developer';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class FlowDemo extends StatefulWidget {
  const FlowDemo({super.key});

  @override
  State<FlowDemo> createState() => _FlowDemoState();
}

class _FlowDemoState extends State<FlowDemo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration animDur = const Duration(seconds: 1 /* milliseconds: 300 */);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: animDur, reverseDuration: animDur, vsync: this)..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Flow Demo"),
      backgroundColor: Colors.grey[850],
      body: /* const Center(
        child: FlutterLogo(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: */
          Center(
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.center_focus_strong,
                color: Colors.white.withAlpha(100),
              ),
            ),
            Flow(
                delegate: CFlowDelegate(_controller, hGap: 80.0, vGap: 80.0),
                clipBehavior: Clip.none,
                children: [0, 1, 2, 3, 4, 5, 6]
                    .map((e) => DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.accents[e], width: 2),
                              borderRadius: BorderRadius.circular(3.0),
                              boxShadow: [
                                // BoxShadow(
                                //   blurStyle: BlurStyle.outer,
                                //   blurRadius: 15.0,
                                //   color: Colors.accents[e].withAlpha(100),
                                //   offset: const Offset(0, 0),
                                // ),
                                BoxShadow(
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 15.0,
                                  spreadRadius: 50.0,
                                  color: Colors.accents[e],
                                ),
                              ]),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              alignment: Alignment.center,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (e == 0) {
                                  _controller.value < 1 ? _controller.forward() : _controller.reverse();
                                } else {
                                  _controller.reverse();
                                }
                                print("Pressed $e button");
                              },
                              icon: Text(
                                "$e",
                                style: TextStyle(color: Colors.accents[e], fontWeight: FontWeight.bold, fontSize: 28.0),
                              ),
                            ),
                          ),
                        ))
                    .toList()),
          ],
        ),
      ),
    );
  }
}

class CFlowDelegate extends FlowDelegate {
  final AnimationController controller;
  final xPosMap = {1: -1, 2: 0, 0: 1};
  final yPosMap = {1: 0.5, 2: 1, 0: 0.5};
  final double hGap;
  final double vGap;

  CFlowDelegate(
    this.controller, {
    this.hGap = 50.0,
    this.vGap = 50.0,
  }) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final totalCount = context.childCount;

    ///First Child
    final firstSize = context.getChildSize(0) ?? Size.zero;
    final firstLoc = Offset((size.width - firstSize.width) / 2, (size.height - firstSize.height) / 2);

    if (controller.value != 0) {
      for (var i = 1; i < 4; i++) {
        final dx = context.getChildSize(i)?.width ?? 0.0;
        context.paintChild(i,
            transform: Matrix4.identity()
              ..translate(firstLoc.dx + hGap * controller.value * xPosMap[(i % 3)]!,
                  firstLoc.dy + (-vGap * controller.value) * yPosMap[i % 3]!));
      }
      for (var i = 4; i < context.childCount; i++) {
        final dx = context.getChildSize(i)?.width ?? 0.0;
        context.paintChild(i,
            transform: Matrix4.identity()
              ..translate(firstLoc.dx + hGap * controller.value * xPosMap[(i % 3)]!,
                  firstLoc.dy + (vGap * controller.value) * yPosMap[i % 3]!));
      }
    }
    context.paintChild(0, transform: Matrix4.identity()..translate(firstLoc.dx, (size.height - firstSize.height) / 2));
  }

  @override
  bool shouldRepaint(covariant CFlowDelegate oldDelegate) {
    if (oldDelegate.controller != controller) return true;
    return false;
  }
}
