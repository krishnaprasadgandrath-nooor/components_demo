import 'package:components_demo/colorful_loader/colorful_loader_scene_two.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

class ColorfulLoaderDemo extends StatelessWidget {
  const ColorfulLoaderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Colorful Loader"),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 300,
          child: SceneBuilderWidget(
            builder: () => SceneController(
              back: ColorfulLoaderSceneTwo(h: 20.0, w: 300.0),
              config: SceneConfig.autoRender,
            ),
          ),
        ),
      ),
    );
  }
}
