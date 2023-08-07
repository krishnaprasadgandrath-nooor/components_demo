// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../utils/custom_math_ext.dart';

// const double _kangleInRadians = math.pi / 2.0;

/// Rotates its child by a integral number of quarter turns.
///
/// Unlike [RenderTransform], which applies a transform just prior to painting,
/// this object applies its rotation prior to layout, which means the entire
/// rotated box consumes only as much space as required by the rotated child.
class LRenderRotatedBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  /// Creates a rotated render box.
  ///
  /// The [angle] argument must not be null.
  LRenderRotatedBox({
    required int angle,
    RenderBox? child,
  }) : _angle = angle {
    this.child = child;
  }

  /// The number of clockwise quarter turns the child should be rotated.
  int get angle => _angle;
  int _angle;
  set angle(int value) {
    if (_angle == value) {
      return;
    }
    _angle = value;
    markNeedsLayout();
  }

  // bool get _isVertical => (angle > 45 && angle < 135) || (angle > 225 && angle < 315);

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child == null) {
      return 0.0;
    }
    final childRect = Rect.fromLTWH(0, 0, child!.size.width, child!.size.height);
    return rotateRectangle(childRect, angle.toDouble(), childRect.center).width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child == null) {
      return 0.0;
    }
    final childRect = Rect.fromLTWH(0, 0, child!.size.width, child!.size.height);
    return rotateRectangle(childRect, angle.toDouble(), childRect.center).width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child == null) {
      return 0.0;
    }
    final childRect = Rect.fromLTWH(0, 0, child!.size.width, child!.size.height);
    return rotateRectangle(childRect, angle.toDouble(), childRect.center).height;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child == null) {
      return 0.0;
    }
    final childRect = Rect.fromLTWH(0, 0, child!.size.width, child!.size.height);
    return rotateRectangle(childRect, angle.toDouble(), childRect.center).height;
  }

  Matrix4? _paintTransform;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return constraints.smallest;
    }
    final childRect = Rect.fromLTWH(0, 0, child!.size.width, child!.size.height);
    final rRect = rotateRectangle(childRect, angle.toDouble(), childRect.center);
    final Size childSize = child!.getDryLayout(BoxConstraints.expand(width: rRect.width, height: rRect.height));
    return childSize;
  }

  @override
  void performLayout() {
    _paintTransform = null;
    if (child != null) {
      child!.layout(constraints, parentUsesSize: true);
      final childRect = Rect.fromLTWH(0, 0, child!.size.width, child!.size.height);
      final rRect = rotateRectangle(childRect, angle.toDouble(), childRect.center);
      size = rRect.size;
      _paintTransform = Matrix4.identity()
        ..translate(size.width / 2.0, size.height / 2.0)
        ..rotateZ(degreesToRadians(angle.toDouble()))
        ..translate(-child!.size.width / 2.0, -child!.size.height / 2.0);
    } else {
      size = constraints.smallest;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    assert(_paintTransform != null || debugNeedsLayout || child == null);
    if (child == null || _paintTransform == null) {
      return false;
    }
    return result.addWithPaintTransform(
      transform: _paintTransform,
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return child!.hitTest(result, position: position);
      },
    );
  }

  void _paintChild(PaintingContext context, Offset offset) {
    context.paintChild(child!, offset);
    /* context.canvas.drawRect(
        const Rect.fromLTWH(0, 0, 80, 80),
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.fill); */
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      _transformLayer.layer = context.pushTransform(
        needsCompositing,
        offset,
        _paintTransform!,
        _paintChild,
        oldLayer: _transformLayer.layer,
      );
    } else {
      _transformLayer.layer = null;
    }
  }

  final LayerHandle<TransformLayer> _transformLayer = LayerHandle<TransformLayer>();

  @override
  void dispose() {
    _transformLayer.layer = null;
    super.dispose();
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    if (_paintTransform != null) {
      transform.multiply(_paintTransform!);
    }
    super.applyPaintTransform(child, transform);
  }
}

class LRotatedBox extends SingleChildRenderObjectWidget {
  /// A widget that rotates its child.
  ///
  /// The [angle] argument must not be null.
  const LRotatedBox({
    super.key,
    required this.angle,
    super.child,
  });

  /// The number of clockwise quarter turns the child should be rotated.
  final int angle;

  @override
  LRenderRotatedBox createRenderObject(BuildContext context) => LRenderRotatedBox(angle: angle);

  @override
  void updateRenderObject(BuildContext context, LRenderRotatedBox renderObject) {
    renderObject.angle = angle;
  }
}
