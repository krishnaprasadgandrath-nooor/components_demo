// q_font_size_button.dart
import 'package:flutter/material.dart';

import 'package:flutter_quill/flutter_quill.dart' hide Text;

//default font size values
final fontSizes = {
  'Small': 'small',
  'Large': 'large',
  'Huge': 'huge',
  'Clear': '0',
};

class QFontSizeButton extends StatelessWidget {
  final QuillController controller;
  const QFontSizeButton(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return QuillFontSizeButton(
      // iconTheme: iconTheme,
      // iconSize: toolbarIconSize,
      attribute: Attribute.size,
      controller: controller,
      items: [
        for (MapEntry<String, String> fontSize in fontSizes.entries)
          PopupMenuItem<String>(
            key: ValueKey(fontSize.key),
            value: fontSize.value,
            child: Text(fontSize.key.toString(), style: TextStyle(color: fontSize.value == '0' ? Colors.red : null)),
          ),
      ],
      onSelected: (newSize) {
        controller
            .formatSelection(Attribute.fromKeyValue('size', newSize == '0' ? null : null /*getFontSize(newSize)*/));
      },
      rawItemsMap: fontSizes,
      // afterButtonPressed: afterButtonPressed,
    );
  }
}
