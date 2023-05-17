import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DEditorUtils {
  static Future<Color?> showColorPicker(BuildContext context, {Color? color, Function(Color)? onColorChanged}) async {
    final color1 = await showDialog<Color>(
      context: context,
      builder: (context) => Center(
          child: Card(
        child: DColorPicker(
          color: color,
          onColorChanged: onColorChanged,
        ),
      )),
    );
    return color1;
  }
}

class DColorPicker extends StatefulWidget {
  final Color? color;
  final Function(Color)? onColorChanged;
  const DColorPicker({
    super.key,
    this.color,
    this.onColorChanged,
  });

  @override
  State<DColorPicker> createState() => _DColorPickerState();
}

class _DColorPickerState extends State<DColorPicker> {
  Color? color;
  late final Function(Color) onColorChanged = widget.onColorChanged ?? (Color color) {};

  @override
  void initState() {
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.loose(const Size(650, 350)),
      child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(onPressed: () => Navigator.pop(context, color), icon: const Icon(Icons.close)),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(650, 300)),
          child: ColorPicker(
            pickerColor: color ?? Colors.blue,
            onColorChanged: (value) {
              color = value;
              setState(() {});
              onColorChanged(value);
            },
          ),
        ),
      ]),
    );
  }
}
