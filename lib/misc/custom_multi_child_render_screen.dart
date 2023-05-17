import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:components_demo/utils/default_appbar.dart';

class CustomMultiChildRenderScreen extends StatefulWidget {
  const CustomMultiChildRenderScreen({super.key});

  @override
  State<CustomMultiChildRenderScreen> createState() => _CustomMultiChildRenderScreenState();
}

class _CustomMultiChildRenderScreenState extends State<CustomMultiChildRenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, 'CustomMultiChildRenderScreen', noLeading: true),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: ColoredBox(
              color: Colors.black54,
              child: ZigZagGrid(
                  children: [1, 2, 3, 4, 5]
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pressed $e')));
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.accents[e],
                                  borderRadius: BorderRadius.circular(e * 4.0),
                                ),
                                child: SizedBox(
                                  height: e * 30.0,
                                  width: e * 30.0,
                                  child: Center(
                                      child: Text(
                                    '$e',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            ),
                          ))
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }
}

class ZigZagGrid extends MultiChildRenderObjectWidget {
  const ZigZagGrid({super.key, required super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return ZigZagRenderObject(children);
  }
}

class ZigZagRenderObject extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _CustomMultiChildData>
    implements RenderBoxContainerDefaultsMixin<RenderBox, _CustomMultiChildData> {
  late List<Widget> _children;
  ZigZagRenderObject(List<Widget> children) {
    _children = children;
  }

  ///Fields
  // final Size _computedSize = Size.zero;
  double _maxWidth1 = 0;
  double _maxWidth2 = 0;

  @override
  double? defaultComputeDistanceToFirstActualBaseline(TextBaseline baseline) {
    return null;
  }

  @override
  double? defaultComputeDistanceToHighestActualBaseline(TextBaseline baseline) {
    return null;
  }

  @override
  bool defaultHitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // Loop over the children in the order they were added
    for (final child in getChildrenAsList()) {
      // Convert the hit-test position to the child's coordinate space
      final childPosition = position - (child.parentData! as _CustomMultiChildData).offset;
      // Call the child's hitTest method
      if (child.hitTest(result, position: childPosition)) {
        return true;
      }
    }
    return false;
  }

  @override
  void defaultPaint(PaintingContext context, Offset offset) {}

  @override
  List<RenderBox> getChildrenAsList() => _children.map((e) => e as RenderBox).toList();

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _CustomMultiChildData) child.parentData = _CustomMultiChildData();
  }

  @override
  void performLayout() {
    final computedSize = _layoutChildren(constraints.maxWidth);
    size = constraints.constrain(computedSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    Offset bottomOffset1 = offset + Offset.zero;
    Offset bottomOffset2 = offset + Offset(_maxWidth1 + 1.0, 0);
    int i = 0;
    RenderBox? child = firstChild;

    while (child != null) {
      if (i % 2 == 1) {
        context.paintChild(child, bottomOffset2);
        bottomOffset2 += Offset(0, child.getMinIntrinsicHeight(constraints.maxWidth));
      } else {
        context.paintChild(child, bottomOffset1);
        bottomOffset1 += Offset(0, child.getMinIntrinsicHeight(constraints.maxWidth));
      }
      i++;
      child = childAfter(child);
    }
  }

  Size _layoutChildren(double maxWidth) {
    Size computedSize = Size.zero;
    _maxWidth1 = 0;
    _maxWidth2 = 0;
    double height1 = 0;
    double height2 = 0;
    int i = 0;
    RenderBox? child = firstChild;
    while (child != null) {
      child.layout(constraints, parentUsesSize: true);
      final width = child.getMinIntrinsicWidth(constraints.maxHeight);
      final height = child.getMinIntrinsicHeight(constraints.maxWidth);
      if (i % 2 == 1) {
        _maxWidth2 = max(_maxWidth2, width);
        height2 += height;
      } else {
        _maxWidth1 = max(_maxWidth1, width);
        height1 += height;
      }
      child = childAfter(child);
      i++;
    }
    computedSize = Size(_maxWidth1 + _maxWidth2 + 2.0, max(height1, height2));
    return computedSize;
  }
}

class _CustomMultiChildData extends ContainerBoxParentData<RenderBox> {}
