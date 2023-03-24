import 'package:components_demo/decoration_editor.dart/decoration_enums.dart';
import 'package:flutter/material.dart';

class DEditingController extends ChangeNotifier {
  BorderRadius _borderRadius = BorderRadius.zero;
  List<BoxShadow> _shadows = [];
  Gradient? _gradient;
  DecorationImage? _image;
  Color? _color;
  BoxShape _shape = BoxShape.rectangle;

  DFillType _fillType = DFillType.solid;

  bool _allBorderRadius = false;

  ///Getters
  DFillType get fillType => _fillType;
  bool get allBorderRadius => _allBorderRadius;
  BorderRadius? get borderRadius => _shape != BoxShape.circle ? _borderRadius : null;
  List<BoxShadow> get shadows => _shadows;
  Gradient? get gradient => _fillType == DFillType.solid ? null : _gradient;
  DecorationImage? get image => _image;
  Color? get color => _fillType == DFillType.solid ? _color : null;
  BoxShape get shape => _shape;

  // Gradient? get gradient {
  //   if (_fillType == DFillType.solid) return null;
  //   if (_gradType == DGradType.linear)
  //     return LinearGradient(colors: _gradientColors, stops: _gradientStops);
  //   else if (_gradType == DGradType.radial)
  //     return RadialGradient(colors: _gradientColors, stops: _gradientStops);
  //   else
  //     return SweepGradient(colors: _gradientColors, stops: _gradientStops);
  // }

  // BoxDecoration get decoration => BoxDecoration(
  //     border: _border,
  //     borderRadius: _borderRadius,
  //     boxShadow: _shadows,
  //     color: _color,
  //     gradient: _gradient,
  //     image: _image,
  //     shape: _shape);

  ///Setters
  set fillType(DFillType value) {
    if (_fillType != value) {
      _fillType = value;
      if (fillType == DFillType.solid && color == null) _setDefaultColor();
      if (fillType == DFillType.gradient && gradient == null) _setDefaultGradient();
      notifyListeners();
    }
  }

  void update({
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? shadows,
    Gradient? gradient,
    DecorationImage? image,
    Color? color,
    BoxShape? shape,
  }) {
    _color = color ?? _color;

    _borderRadius = borderRadius ?? _borderRadius;
    _shadows = shadows ?? _shadows;
    _gradient = gradient ?? _gradient;
    _image = image ?? _image;
    _shape = shape ?? _shape;
    notifyListeners();
  }

  void _setDefaultColor() {
    _color = Colors.black87;
  }

  void _setDefaultGradient() {
    _gradient = const LinearGradient(colors: [Colors.red, Colors.blue]);
  }

  void changeAllBorderRadius(bool value) {
    _allBorderRadius = value;
    notifyListeners();
  }

  void updateBorderRadius(BorderRadius borderRadius) {
    _borderRadius = borderRadius;
    notifyListeners();
  }

  void addShadow(BoxShadow boxShadow) {
    _shadows.add(boxShadow);
    notifyListeners();
  }

  void removeShadow(int index) {
    _shadows.removeAt(index);
    notifyListeners();
  }

  void updateShadow(int index, BoxShadow value) {
    _shadows[index] = value;
    notifyListeners();
  }
}
