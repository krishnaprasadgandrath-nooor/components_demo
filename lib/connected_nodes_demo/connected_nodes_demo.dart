import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:graphx/graphx.dart';

import 'connected_nodes_scene.dart';

class ConnectedNodesDemo extends StatelessWidget {
  const ConnectedNodesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Connected Nodes Demo"),
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: SceneBuilderWidget(
          builder: () => SceneController(
            config: SceneConfig.interactive,
            back: ConnectedNodesScene(),
          ),
        ),
      ),
    );
  }
}
