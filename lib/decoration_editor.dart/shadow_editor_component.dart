import 'package:flutter/material.dart';

import 'd_editor_utils.dart';
import '../number_input.dart';

class DShadowEditor extends StatefulWidget {
  final int index;
  final BoxShadow shadow;
  final Function(BoxShadow) updateShadow;

  final VoidCallback deleteShadow;
  const DShadowEditor(
    this.shadow, {
    super.key,
    required this.index,
    required this.updateShadow,
    required this.deleteShadow,
  });

  @override
  State<DShadowEditor> createState() => _DShadowEditorState();
}

class _DShadowEditorState extends State<DShadowEditor> {
  late BoxShadow shadow = widget.shadow;
  bool isExpanded = false;

  @override
  void didUpdateWidget(covariant DShadowEditor oldWidget) {
    if (oldWidget.shadow != widget.shadow || oldWidget.index != widget.index) {
      shadow = widget.shadow;
      setState(() {});
    } else {
      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.0,
          child: ColoredBox(
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shadow ${widget.index + 1}"),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          isExpanded = !isExpanded;
                          setState(() {});
                        },
                        icon: Icon(
                          isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        )),
                    IconButton(onPressed: widget.deleteShadow, icon: const Icon(Icons.delete))
                  ],
                )
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          SizedBox(
            width: 180.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    final color = await DEditorUtils.showColorPicker(context, color: shadow.color);
                    updateShadow(color: color);
                  },
                  child: ColoredBox(
                    color: shadow.color,
                    child: const SizedBox(height: 30.0, width: 40.0),
                  ),
                ),
                DropdownButton(
                  value: shadow.blurStyle,
                  items: BlurStyle.values.map((e) => DropdownMenuItem(value: e, child: Text(e.name))).toList(),
                  onChanged: (value) {
                    if (value != null) updateShadow(blurStyle: value);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80.0,
            width: 180.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80.0,
                  child: NumberInput(
                    label: "dx",
                    initialValue: shadow.offset.dx,
                    onChanged: (x) => updateShadow(offset: Offset(x, shadow.offset.dy)),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                  child: NumberInput(
                    label: "dy",
                    initialValue: shadow.offset.dx,
                    onChanged: (y) => updateShadow(offset: Offset(shadow.offset.dx, y)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80.0,
            width: 180.0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 80.0,
                  child: NumberInput(
                    label: "blur",
                    initialValue: shadow.blurRadius,
                    onChanged: (blur) => updateShadow(blurRadius: blur),
                  ),
                ),
                SizedBox(
                  width: 80.0,
                  child: NumberInput(
                    label: "spread",
                    initialValue: shadow.spreadRadius,
                    onChanged: (spread) => updateShadow(spreadRadius: spread),
                  ),
                ),
              ],
            ),
          )
        ]
      ],
    );
  }

  void updateShadow({Color? color, Offset? offset, double? blurRadius, double? spreadRadius, BlurStyle? blurStyle}) {
    shadow = BoxShadow(
      color: color ?? shadow.color,
      offset: offset ?? shadow.offset,
      blurRadius: blurRadius ?? shadow.blurRadius,
      spreadRadius: spreadRadius ?? shadow.spreadRadius,
      blurStyle: blurStyle ?? shadow.blurStyle,
    );
    setState(() {});
    widget.updateShadow(shadow);
  }
}
