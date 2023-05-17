import 'dart:ui';

import 'package:flutter/material.dart';

///A widget which makes it easier to visualize alignment
///property by using offsets and provides callback to change
///notify changed offset between the given boundaries
class AlignOffsetEditor extends StatefulWidget {
  final Offset value;
  final double boundary;
  final void Function(double x, double y)? onChanged;

  const AlignOffsetEditor({
    super.key,
    this.value = const Offset(0, 0),
    this.boundary = 1,
    this.onChanged,
  });

  @override
  State<AlignOffsetEditor> createState() => _AlignOffsetEditorState();

  double get lowerBound => -boundary;
  double get upperBound => boundary;
}

class _AlignOffsetEditorState extends State<AlignOffsetEditor> {
  late Offset position = Offset(boxSize / 2, boxSize / 2);
  final double ballSize = 10;
  Alignment? safeAlign;
  final double boxSize = 100;

  bool ignoreDrag = false;

  @override
  void initState() {
    if (widget.boundary <= 0) throw Exception('extreme value cannot be a non-natural number');
    updateinitialValue();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AlignOffsetEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.boundary != oldWidget.boundary && widget.onChanged != oldWidget.onChanged) {
      updateinitialValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black54, strokeAlign: BorderSide.strokeAlignOutside)),
      child: SizedBox(
        height: boxSize,
        width: boxSize,
        child: ColoredBox(
          color: Colors.white,
          child: Stack(
            children: [
              GestureDetector(
                  onTapDown: (details) {
                    final dx = details.localPosition.dx;
                    final dy = details.localPosition.dy;

                    ///100 is used since the widget height and width are 100

                    position = Offset(dx, dy);
                    notifyChange();
                  },
                  /*  onLongPress: () {
                    position = Offset(boxSize / 2, boxSize / 2);
                    notifyChange();
                  }, */
                  child: ColoredBox(color: Colors.grey.withAlpha(100), child: const SizedBox.expand())),
              Align(
                alignment: Alignment.topCenter,
                child: ColoredBox(
                  color: Colors.black54,
                  child: SizedBox(
                    width: 1,
                    height: boxSize,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ColoredBox(
                  color: Colors.black54,
                  child: SizedBox(
                    width: boxSize,
                    height: 1,
                  ),
                ),
              ),
              Positioned(
                top: position.dy - ballSize / 2,
                left: position.dx - ballSize / 2,
                child: GestureDetector(
                  onPanUpdate: handlePosUpdate,
                  onPanCancel: () => ignoreDrag = false,
                  onPanEnd: (details) => ignoreDrag = false,
                  child: DecoratedBox(
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black54)),
                    child: SizedBox(height: ballSize, width: ballSize),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void handlePosUpdate(DragUpdateDetails details) {
    if (ignoreDrag) return;
    final delta = details.delta;
    final nextPos = position + delta;
    if (nextPos.dx >= 0 && nextPos.dx <= boxSize && nextPos.dy >= 0 && nextPos.dy <= boxSize) {
      setState(() {
        position += details.delta;
      });
      notifyChange();
    } else {
      ignoreDrag = true;
    }
  }

  void notifyChange() {
    final xValue = lerpDouble(widget.lowerBound, widget.upperBound, position.dx / boxSize);
    final yValue = lerpDouble(widget.lowerBound, widget.upperBound, position.dy / boxSize);
    if (xValue != null && yValue != null) widget.onChanged?.call(xValue, yValue);
  }

  void updateinitialValue() {
    if (widget.value.dx.abs() <= widget.boundary && widget.value.dy.abs() <= widget.boundary) {
      final offset = Offset(
        lerpDouble(0, boxSize, ((widget.value.dx - widget.lowerBound) / (widget.upperBound - widget.lowerBound)))!,
        lerpDouble(0, boxSize, ((widget.value.dy - widget.lowerBound) / (widget.boundary - widget.lowerBound)))!,
      );
      position = offset;
    }
  }
}
