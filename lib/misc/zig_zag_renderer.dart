import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ZigZagLayoutScreen extends StatelessWidget {
  const ZigZagLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ZigZagLayout(
        children: [1, 2, 3, 4, 5]
            .map((e) => ColoredBox(
                  color: Colors.accents[e],
                  child: SizedBox(
                    height: e * 20.0,
                    width: e * 20.0,
                    child: Center(
                      child: Text(
                        '$e',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    ));
  }
}

class ZigZagLayout extends MultiChildRenderObjectWidget {
  ZigZagLayout({
    Key? key,
    required List<Widget> children,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderZigZagLayout();
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderZigZagLayout renderObject) {
    renderObject.markNeedsLayout();
  }
}

class RenderZigZagLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ZigZagParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, ZigZagParentData> {
  @override
  void performLayout() {
    double maxWidth = 0.0;
    double totalHeight = 0.0;

    int i = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(constraints, parentUsesSize: true);
      final double childWidth = child.size.width;
      final double childHeight = child.size.height;

      if (i % 2 == 0) {
        // Even index, place the child to the left of the previous child
        final double prevChildWidth = i == 0 ? 0.0 : childBefore(child)!.size.width;
        final double dx = prevChildWidth - childWidth;
        (child.parentData! as ZigZagParentData).offset = Offset(dx, totalHeight);
      } else {
        // Odd index, place the child below and to the right of the previous child
        final double prevChildWidth = i == 1 ? 0.0 : childBefore(childBefore(child)!)!.size.width;
        final double dx = prevChildWidth;
        final double dy = childHeight;
        (child.parentData! as ZigZagParentData).offset = Offset(dx, totalHeight + dy);
        totalHeight += dy;
        maxWidth = math.max(maxWidth, prevChildWidth + childWidth);
      }

      i++;
      child = childAfter(child);
    }

    size = Size(maxWidth, totalHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as ZigZagParentData;
      context.paintChild(child, offset + childParentData.offset);
      child = childParentData.nextSibling;
    }
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! ZigZagParentData) child.parentData = ZigZagParentData();
  }
}

class ZigZagParentData extends ContainerBoxParentData<RenderBox> {}
