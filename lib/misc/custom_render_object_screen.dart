import 'dart:math';

import 'package:flutter/material.dart';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:flutter/src/semantics/semantics.dart';

class CustomRenderObjectScreen extends StatefulWidget {
  const CustomRenderObjectScreen({super.key});

  @override
  State<CustomRenderObjectScreen> createState() => _CustomRenderObjectScreenState();
}

class _CustomRenderObjectScreenState extends State<CustomRenderObjectScreen> {
  final TextEditingController controller = TextEditingController();

  String _message = 'Hello world!';

  TextDirection _direction = TextDirection.ltr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, 'Custom Render Object Demo', noLeading: true),
      body: Stack(
        children: [
          Center(
              child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300.0),
            child: Directionality(
                textDirection: _direction, child: CustomMessageRender(message: _message, sentAt: '2 minutes ago')),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      _direction = _direction == TextDirection.ltr ? TextDirection.rtl : TextDirection.ltr;
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.directions,
                      color: Colors.black,
                    )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    )),
                  ),
                )),
                IconButton(
                    onPressed: updateMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.black,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  void updateMessage() {
    if (_message != controller.text) {
      _message = controller.text;
      setState(() {});
    }
  }
}

class CustomMessageRender extends LeafRenderObjectWidget {
  final String message;
  final String sentAt;
  CustomMessageRender({
    required this.message,
    required this.sentAt,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomMessageRenderObject(
      message: message,
      sentAt: sentAt,
      direction: Directionality.of(context),
      style: DefaultTextStyle.of(context).style,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant CustomMessageRenderObject renderObject) {
    if (renderObject.message != message) {
      renderObject.message = message;
    }
    if (renderObject.sentAt != sentAt) {
      renderObject.sentAt = sentAt;
    }
    final style = DefaultTextStyle.of(context).style;
    if (style != renderObject.style) {
      renderObject.style = style;
    }
    final direction = Directionality.of(context);
    if (direction != renderObject.direction) {
      renderObject.direction = direction;
    }
  }
}

class CustomMessageRenderObject extends RenderBox {
  CustomMessageRenderObject({
    required String message,
    required String sentAt,
    TextStyle style = const TextStyle(),
    TextDirection direction = TextDirection.ltr,
  }) {
    _message = message;
    _sentAt = sentAt;
    _style = style;
    _direction = direction;
    _messagePainter = TextPainter(text: TextSpan(text: _message, style: _style), textDirection: _direction);
    _sentAtPainter = TextPainter(
        text: TextSpan(text: _sentAt, style: _style.copyWith(color: Colors.grey, fontSize: 10.0)),
        textDirection: _direction);
  }

  late String _message;
  late String _sentAt;
  late TextStyle _style;
  late TextDirection _direction;
  late TextPainter _messagePainter;
  late TextPainter _sentAtPainter;

  bool _canFitInline = false;
  Size _computedSize = Size.zero;
  double _sentAtWidth = 0;
  double _sentAtHeight = 0;

  ///Getters
  String get message => _message;
  String get sentAt => _sentAt;
  TextDirection get direction => _direction;
  TextStyle get style => _style;
  TextPainter get messagePainter =>
      TextPainter(text: TextSpan(text: _message, style: _style), textDirection: _direction);
  TextPainter get sentAtPainter =>
      TextPainter(text: TextSpan(text: _sentAt, style: _style.copyWith(color: Colors.grey, fontSize: 10.0)));

  ///Setters
  set message(String value) {
    if (value == _message) return;
    _message = value;
    _messagePainter = messagePainter;
    //TODo
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  set sentAt(String value) {
    if (value == _message) return;
    _sentAt = value;
    _sentAtPainter = sentAtPainter;
    //TODo
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  set direction(TextDirection value) {
    if (value == _direction) return;
    _direction = value;
    //TODo
    _messagePainter.textDirection = _direction;
    _sentAtPainter.textDirection = _direction;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  set style(TextStyle value) {
    if (value == _style) return;
    _style = value;
    //TODo
    markNeedsLayout();
  }

  @override
  void performLayout() {
    _computedSize = _layoutText(constraints.maxWidth);
    size = constraints.constrain(_computedSize);
  }

  Size _layoutText(double width) {
    _messagePainter.layout(maxWidth: width);
    _sentAtPainter.layout(maxWidth: width);
    double maxLineWidth = 0;
    final lines = _messagePainter.computeLineMetrics();
    for (var line in lines) {
      maxLineWidth = max(maxLineWidth, line.width);
    }

    _sentAtWidth = _sentAtPainter.width;
    _sentAtHeight = _sentAtPainter.height;
    final lastLineWidth = lines.last.width;

    _canFitInline = lastLineWidth + (_sentAtWidth * 1.06) <= width;
    Size tempSize = Size.zero;
    if (_canFitInline) {
      if (lines.length == 1) {
        tempSize = Size(maxLineWidth + (_sentAtWidth * 1.06), _messagePainter.height);
      } else {
        tempSize = Size(maxLineWidth, _messagePainter.height);
      }
    } else {
      tempSize = Size(maxLineWidth, _messagePainter.height + _sentAtPainter.height);
    }
    return tempSize;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    if (_messagePainter.text?.toPlainText() == '') return;
    _messagePainter.paint(canvas, offset);
    _sentAtPainter.paint(canvas,
        Offset(offset.dx + _computedSize.width - _sentAtWidth, offset.dy + _computedSize.height - _sentAtHeight));
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = true;
    config.label = '$_message,sentAt $_sentAt';
    config.textDirection = _direction;
  }
}
