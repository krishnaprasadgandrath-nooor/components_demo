import 'dart:async';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/util_data_models.dart';
import 'snake_game_controller/snake_game_controller.dart';

final Set<LogicalKeyboardKey> gameKeys = {
  LogicalKeyboardKey.arrowUp,
  LogicalKeyboardKey.arrowDown,
  LogicalKeyboardKey.arrowLeft,
  LogicalKeyboardKey.arrowRight,
  LogicalKeyboardKey.space,
};
final Map<LogicalKeyboardKey, SDirection> directionMap = {
  LogicalKeyboardKey.arrowUp: SDirection.up,
  LogicalKeyboardKey.arrowDown: SDirection.down,
  LogicalKeyboardKey.arrowLeft: SDirection.left,
  LogicalKeyboardKey.arrowRight: SDirection.right,
};

class SnakeGameDemo extends StatefulWidget {
  const SnakeGameDemo({super.key});

  @override
  State<SnakeGameDemo> createState() => _SnakeGameDemoState();
}

class _SnakeGameDemoState extends State<SnakeGameDemo> {
  final double unitSize = 10.0;
  late final SnakeController snakeGameController = SnakeController(stageSize: const Size(300, 300), unitSize: unitSize);

  final FocusNode stageFocusNode = FocusNode();

  Timer? timer;
  @override
  void initState() {
    snakeGameController.addListener(gameUpdateListener);
    super.initState();
    stageFocusNode.requestFocus();
  }

  void gameUpdateListener() => setState(() {});

  @override
  void dispose() {
    snakeGameController.removeListener(gameUpdateListener);
    snakeGameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, 'Snake Game Demo'),
      body: SizedBox.expand(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RawKeyboardListener(
              focusNode: stageFocusNode,
              onKey: handleKeyEvent,
              child: SizedBox(
                height: 300,
                width: 300,
                child: Stack(
                  children: [
                    ///Stage
                    DecoratedBox(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 1),
                          color: const Color.fromARGB(255, 21, 20, 20)),
                      child: const SizedBox.expand(),
                    ),
                    /*  Consumer(
                      builder: (context, ref, child) {
                        ref.watch(ChangeNotifierProvider((ref) => snakeGameController));
                        return  */
                    Stack(
                      children: [
                        ...snakeGameController.snake.snakeBody
                            .map((e) => Positioned(
                                top: e.y,
                                left: e.x,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.red, border: Border.all(color: Colors.black, width: 1)),
                                  child: SizedBox(
                                    width: unitSize,
                                    height: unitSize,
                                  ),
                                )))
                            .toList()
                      ],
                    )
                    /*    },
                    ) */
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void handleKeyEvent(RawKeyEvent value) {
    final isKeyDownEvent = value is RawKeyDownEvent;
    if (!isKeyDownEvent) return;
    final logicKey = value.logicalKey;
    if (!gameKeys.contains(logicKey)) return;
    if (!directionMap.containsKey(logicKey)) {
      ///TODO non Direction Keys
      // _handleNonDirectionKeys(logicKey);
      ///TODO Just For Testing Purpose
      if (logicKey == LogicalKeyboardKey.space) {
        snakeGameController.snake.eat();
      }
      return;
    } else {
      snakeGameController.changeSnakeDirection(directionMap[logicKey]!);
    }
  }
}
