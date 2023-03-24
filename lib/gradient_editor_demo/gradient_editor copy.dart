import 'package:components_demo/decoration_editor.dart/d_editor_utils.dart';
import 'package:components_demo/decoration_editor.dart/decoration_enums.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

final Map<String, AlignmentGeometry> alignmentValues = {
  "topLeft": Alignment.topLeft,
  "topCenter": Alignment.topCenter,
  "topRight": Alignment.topRight,
  "centerLeft": Alignment.centerLeft,
  "center": Alignment.center,
  "centerRight": Alignment.centerRight,
  "bottomLeft": Alignment.bottomLeft,
  "bottomCenter": Alignment.bottomCenter,
  "bottomRight": Alignment.bottomRight,
};

class GradientEditor extends StatefulWidget {
  final Gradient gradient;
  final Function(Gradient) updateGradient;

  const GradientEditor(
    this.gradient, {
    super.key,
    required this.updateGradient,
  });

  @override
  State<GradientEditor> createState() => _GradientEditorState();
}

class _GradientEditorState extends State<GradientEditor> {
  late Gradient _gradient = widget.gradient;
  late Function(Gradient) updateGradient = widget.updateGradient;

  ///Getters
  DGradType get dGradType => _gradient.dGradType;

  @override
  void didUpdateWidget(covariant GradientEditor oldWidget) {
    if (oldWidget.gradient != widget.gradient) {
      _gradient = widget.gradient;

      setState(() {});
    } else {
      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30.0,
          child: DropdownButton(
            value: dGradType,
            items: DGradType.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
            onChanged: (value) {
              if (value != null) changeType(value);
            },
          ),
        ),
        if (dGradType == DGradType.sweep)
          sweepGradientEditor()
        else if (dGradType == DGradType.radial)
          radialGradientEditor()
        else
          linearGradientEditor()
      ],
    );
  }

  Widget linearGradientEditor() {
    final oGradient = (_gradient as LinearGradient);
    return AnimatedSize(
      duration: kThemeAnimationDuration,
      child: SizedBox(
        width: 180.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text("Begin : "),
                DropdownButton<AlignmentGeometry>(
                  value: oGradient.begin,
                  items: alignmentValues.entries
                      .map((e) => DropdownMenuItem<AlignmentGeometry>(value: e.value, child: Text(e.key)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) updateLinearGradient(begin: value);
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text("End : "),
                DropdownButton<AlignmentGeometry>(
                  value: oGradient.end,
                  items: alignmentValues.entries
                      .map((e) => DropdownMenuItem<AlignmentGeometry>(value: e.value, child: Text(e.key)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) updateLinearGradient(end: value);
                  },
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  constraints: const BoxConstraints(minHeight: 30.0, maxHeight: 30.0),
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Colors"),
                      IconButton(
                          onPressed: () {
                            updateLinearGradient(
                                colors: List<Color>.from(oGradient.colors)..add(Colors.black12),
                                stops: (oGradient.stops ?? List.generate(oGradient.colors.length, (index) => 0))
                                  ..add(1.0));
                          },
                          icon: const Icon(Icons.add)),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minHeight: 50.0, maxHeight: 150.0, maxWidth: 180.0, minWidth: 180.0),
                  child: ListView.builder(
                    itemCount: oGradient.colors.length,
                    itemBuilder: (context, index) {
                      final _color = oGradient.colors[index];
                      final _stop = oGradient.stops?[index] ?? 0;

                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints.expand(height: 55.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () async {
                                  final color = await DEditorUtils.showColorPicker(context, color: _color);
                                  if (color != null) {
                                    updateLinearGradient(
                                        colors: List.from(oGradient.colors)..replaceRange(index, index + 1, [color]));
                                  }
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: _color, border: Border.all(color: Colors.black)),
                                  child: const SizedBox.expand(),
                                ),
                              )),
                              SizedBox(
                                width: 100.0,
                                child: NumberInputWithIncrementDecrement(
                                  controller: TextEditingController(),
                                  initialValue: _stop,
                                  max: 1.0,
                                  min: 0.0,
                                  incDecFactor: 0.1,
                                  onIncrement: (newValue) {
                                    final _stop = newValue.toDouble();
                                    updateLinearGradient(
                                        stops: List<double>.from(oGradient.stops ??
                                            List<double>.generate(oGradient.colors.length, (index) => index * 0.1)
                                          ..replaceRange(index, index + 1, [_stop])));
                                  },
                                  onDecrement: (newValue) {
                                    final _stop = newValue.toDouble();
                                    updateLinearGradient(
                                        stops: List<double>.from(oGradient.stops ??
                                            List<double>.generate(oGradient.colors.length, (index) => index * 0.1)
                                          ..replaceRange(index, index + 1, [_stop])));
                                  },
                                ),
                              ),
                              IconButton(
                                  onPressed: oGradient.colors.length > 2
                                      ? () {
                                          updateLinearGradient(
                                            colors: List<Color>.from(oGradient.colors)..removeAt(index),
                                            stops: List<double>.from(oGradient.stops ??
                                                List<double>.generate(oGradient.colors.length, (index) => 0)
                                              ..removeAt(index)),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget sweepGradientEditor() {
    return Placeholder();
  }

  Widget radialGradientEditor() {
    return Placeholder();
  }

  void updateLinearGradient({
    List<Color>? colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<double>? stops,
    TileMode? tileMode,
    GradientTransform? transform,
  }) {
    final oGradient = (_gradient as LinearGradient);
    _gradient = LinearGradient(
      colors: colors ?? oGradient.colors,
      begin: begin ?? oGradient.begin,
      end: end ?? oGradient.end,
      stops: stops ?? oGradient.stops,
      tileMode: tileMode ?? oGradient.tileMode,
      transform: transform ?? oGradient.transform,
    );
    setState(() {});
    updateGradient(_gradient);
  }

  void upgradeRadialGradient({
    List<Color>? colors,
    List<double>? stops,
    TileMode? tileMode,
    GradientTransform? transform,
    AlignmentGeometry? center,
    AlignmentGeometry? focal,
    double? focalRadius,
    double? radius,
  }) {
    final oGradient = (_gradient as RadialGradient);
    _gradient = RadialGradient(
      colors: colors ?? oGradient.colors,
      stops: stops ?? oGradient.stops,
      tileMode: tileMode ?? oGradient.tileMode,
      transform: transform ?? oGradient.transform,
      center: center ?? oGradient.center,
      focal: focal ?? oGradient.focal,
      focalRadius: focalRadius ?? oGradient.focalRadius,
      radius: radius ?? oGradient.radius,
    );
    setState(() {});
    updateGradient(_gradient);
  }

  void upgradeSweepGradient({
    List<Color>? colors,
    List<double>? stops,
    TileMode? tileMode,
    GradientTransform? transform,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
  }) {
    final oGradient = (_gradient as SweepGradient);
    _gradient = SweepGradient(
      colors: colors ?? oGradient.colors,
      stops: stops ?? oGradient.stops,
      tileMode: tileMode ?? oGradient.tileMode,
      transform: transform ?? oGradient.transform,
      center: center ?? oGradient.center,
      startAngle: startAngle ?? oGradient.startAngle,
      endAngle: endAngle ?? oGradient.endAngle,
    );
    setState(() {});
    updateGradient(_gradient);
  }

  void changeType(DGradType type) {
    final colors = [Colors.black, Colors.white];
    if (type == DGradType.sweep) {
      _gradient = SweepGradient(colors: colors);
    } else if (type == DGradType.radial) {
      _gradient = RadialGradient(colors: colors);
    } else {
      _gradient = LinearGradient(colors: colors);
    }
    updateGradient(_gradient);
    setState(() {});
  }
}

extension DGradTypeUtil on Gradient {
  DGradType get dGradType {
    if (this is SweepGradient) {
      return DGradType.sweep;
    } else if (this is RadialGradient) {
      return DGradType.radial;
    } else {
      return DGradType.linear;
    }
  }
}

extension AlignmentGeometryUtil on AlignmentGeometry {
  Offset get toOffset {
    final align = this.resolve(TextDirection.ltr);
    return Offset(align.x, align.y);
  }
}
