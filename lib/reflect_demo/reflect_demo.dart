import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

class WidgetCopier extends StatefulWidget {
  final Widget child;
  final void Function(ui.Image image) updateImage;

  const WidgetCopier({Key? key, required this.updateImage, required this.child}) : super(key: key);

  @override
  State<WidgetCopier> createState() => _WidgetCopierState();
}

class _WidgetCopierState extends State<WidgetCopier> {
  final GlobalKey _widgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) => captureWidget());
  }

  Future<void> captureWidget() async {
    RenderRepaintBoundary? boundary = _widgetKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    widget.updateImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _widgetKey,
      child: widget.child,
    );
  }
}

class ReflectionImageDemo extends StatefulWidget {
  const ReflectionImageDemo({super.key});

  @override
  State<ReflectionImageDemo> createState() => _ReflectionImageDemoState();
}

class _ReflectionImageDemoState extends State<ReflectionImageDemo> {
  Image? _image;

  bool inProgress = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.red,
              child: const Center(
                child: Text(
                  'Hello World',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 50),
            WidgetCopier(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: const Center(
                    child: TextField(
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),
                updateImage: (ui.Image image) async {
                  if (inProgress) return;
                  setState(() {
                    inProgress = true;
                  });
                  final pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);

                  _image = Image.memory(Uint8List.view(pngBytes!.buffer));
                  setState(() {
                    inProgress = false;
                  });
                }),
            const SizedBox(height: 50),
            SizedBox(height: 200, width: 200, child: _image != null ? _image! : const ColoredBox(color: Colors.red)),
            _image != null
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.transparent,
                          Colors.white,
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: _image!,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
