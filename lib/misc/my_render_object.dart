// ignore_for_file: library_private_types_in_public_api

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:uuid/uuid.dart';

import 'package:components_demo/utils/default_appbar.dart';

class MyRenderObjectScreen extends StatefulWidget {
  const MyRenderObjectScreen({super.key});

  @override
  State<MyRenderObjectScreen> createState() => _MyRenderObjectScreenState();
}

class _MyRenderObjectScreenState extends State<MyRenderObjectScreen> {
  final TextEditingController _msgController = TextEditingController();
  Map<String, MyMessage> conversation = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "My Render Object Demo"),
      body: ColoredBox(
        color: Colors.black38,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...conversation.entries
                .map((e) => Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75, maxHeight: 100.0),
                          child: MyMessageRenderer(message: e.value),
                        ),
                      ),
                    ))
                .toList(),
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: conversation.length,
            //       shrinkWrap: true,
            //       itemBuilder: (context, index) {
            //         final msg = conversation.entries.toList()[index];
            //         return Align(
            //             alignment: Alignment.centerRight,
            //             child: Padding(
            //                 padding: const EdgeInsets.all(5.0),
            //                 child: ConstrainedBox(
            //                     constraints:
            //                         BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75, maxHeight: 500),
            //                     child: MyMessageRenderer(message: msg.value))));
            //       }),
            // ),
            const SizedBox(height: 10),
            footer(),
            const SizedBox(height: 3.0),
          ],
        ),
      ),
    );
  }

  Widget footer() {
    return SizedBox(
      height: 40.0,
      child: ValueListenableBuilder(
        valueListenable: _msgController,
        builder: (context, value, child) => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /* ColoredBox(
              color: Colors.blueGrey.shade300,
              child: */
            const Center(
                widthFactor: 1.5,
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                )
                // )
                ),
            const SizedBox(width: 3),
            Expanded(
                child: TextField(
              controller: _msgController,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              onEditingComplete: _msgController.text.isEmpty ? null : sendMessage,
              cursorColor: Colors.blueGrey,
              decoration: InputDecoration(
                border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1.5)),
                fillColor: const Color.fromRGBO(255, 255, 255, 0.603).withAlpha(50),
                filled: true,
                contentPadding: const EdgeInsets.all(5.0),
              ),
            )),
            const SizedBox(width: 3),
            DecoratedBox(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.0), color: Colors.white.withAlpha(100)),
              child: IconButton(
                onPressed: _msgController.text.isEmpty ? null : sendMessage,
                icon: Transform.rotate(
                    angle: -45 * math.pi / 180, alignment: Alignment.center, child: const Icon(Icons.send)),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 3)
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    final newMsg = MyMessage(message: _msgController.text, sentAt: DateTime.now());
    conversation[newMsg.id] = newMsg;
    _msgController.clear();
    setState(() {});
  }
}

class NonROMessageBubble extends StatelessWidget {
  final MyMessage msg;
  const NonROMessageBubble(
    this.msg, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(msg.message),
            // const SizedBox(height: 10.0),
            SizedBox(
              height: 10.0,
              width: 50.0,
              child: Text(
                msg.sentAt.toHHMMAA,
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 10, color: Colors.grey.withAlpha(200)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyMessage {
  late final String id;
  final String message;
  final DateTime sentAt;
  MyMessage({
    required this.message,
    required this.sentAt,
  }) {
    id = const Uuid().v1();
  }
}

extension DateTimeExtension on DateTime {
  String get toHHMMAA {
    return DateFormat('hh:mm aa').format(this);
  }
}

class MyMessageRenderer extends LeafRenderObjectWidget {
  final MyMessage message;
  const MyMessageRenderer({
    super.key,
    required this.message,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyMessageRenderObject(message: message);
  }

  @override
  void updateRenderObject(BuildContext context, _MyMessageRenderObject renderObject) {
    renderObject.message = message;
  }
}

class _MyMessageRenderObject extends RenderBox {
  late MyMessage _message;
  _MyMessageRenderObject({
    required MyMessage message,
  }) {
    _message = message;
  }

  late TextPainter _messagePainter =
      TextPainter(text: TextSpan(text: _message.message), textDirection: TextDirection.ltr);
  late TextPainter _timePainter =
      TextPainter(text: TextSpan(text: _message.sentAt.toHHMMAA), textDirection: TextDirection.ltr);

  ///Fields
  bool canFit = false;
  Offset offset = Offset.zero;

  ///Getters
  MyMessage get message => _message;

  set message(MyMessage value) {
    if (value == _message) return;
    _message = value;
    _messagePainter = TextPainter(text: TextSpan(text: _message.message));
    _timePainter = TextPainter(text: TextSpan(text: _message.sentAt.toHHMMAA));
  }

  @override
  bool get hasSize => true;

  @override
  Size get size => _layoutMessageAndTime(constraints.maxWidth);

  @override
  void performLayout() {
    ///Calculatiung layouts
    final maxAvailWidth = constraints.maxWidth;

    Size computedSize = _layoutMessageAndTime(maxAvailWidth);

    ///return constraints
    constraints.constrain(computedSize);
  }

  Size _layoutMessageAndTime(double maxAvailWidth) {
    _messagePainter.layout(maxWidth: maxAvailWidth, minWidth: 0.0);

    _timePainter.layout(maxWidth: maxAvailWidth);
    double maxLineWidth = 0;
    final lines = _messagePainter.computeLineMetrics();
    for (var line in lines) {
      if (line.width > maxLineWidth) maxLineWidth = line.width;
    }
    final sentAtWidth = _timePainter.width;
    double lastLineWidth = 0;
    if (lines.length == 1) {
      lastLineWidth = lines.first.width;
    } else {
      lastLineWidth = lines.last.width;
    }

    ///Calculating size based on fitting
    final messageSize = Size(maxLineWidth, _messagePainter.height);
    final lineHeight = lines.last.height;
    final lastLineWithDateWidth = (lastLineWidth + (sentAtWidth * 1.08));
    canFit = lastLineWithDateWidth > maxAvailWidth;
    Size computedSize = Size.zero;
    if (!canFit) {
      computedSize = Size(messageSize.width, messageSize.height + _timePainter.height);
    } else {
      if (lines.length == 1) {
        computedSize = Size(lastLineWithDateWidth, lineHeight);
      } else {
        computedSize = Size(maxLineWidth, messageSize.height);
      }
    }
    return computedSize;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_messagePainter.text?.toPlainText() == '') return;
    _messagePainter.paint(context.canvas, offset);
  }
}
