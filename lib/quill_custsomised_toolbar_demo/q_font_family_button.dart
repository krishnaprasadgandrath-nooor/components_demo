import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'package:flutter_quill/src/widgets/toolbar/quill_font_family_button.dart';

final fontFamilies = {
  'Sans Serif': 'sans-serif',
  'Serif': 'serif',
  'Monospace': 'monospace',
  'Ibarra Real Nova': 'ibarra-real-nova',
  'SquarePeg': 'square-peg',
  'Nunito': 'nunito',
  'Pacifico': 'pacifico',
  'Roboto Mono': 'roboto-mono',
  'Clear': 'Clear'
};

class QFontFamilyButton extends StatelessWidget {
  final QuillController controller;
  const QFontFamilyButton(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return QuillFontFamilyButton(
      attribute: Attribute.font,
      controller: controller,
      items: [
        for (MapEntry<String, String> fontFamily in fontFamilies.entries)
          PopupMenuItem<String>(
            key: ValueKey(fontFamily.key),
            value: fontFamily.value,
            child: Text(fontFamily.key.toString(),
                style: TextStyle(color: fontFamily.value == 'Clear' ? Colors.red : null)),
          ),
      ],
      onSelected: (newFont) {
        controller.formatSelection(Attribute.fromKeyValue('font', newFont == 'Clear' ? null : newFont));
      },
      rawItemsMap: fontFamilies,
      // afterButtonPressed: afterButtonPressed,
    );
  }
}
