// quill_customised_toolbar.dart

import 'package:components_demo/quill_custsomised_toolbar_demo/q_font_family_button.dart';
import 'package:components_demo/quill_custsomised_toolbar_demo/q_font_size_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'q_line_height_button.dart';

class QuillCustomToolBar extends StatefulWidget {
  final QuillController controller;
  const QuillCustomToolBar(this.controller, {super.key});

  @override
  State<QuillCustomToolBar> createState() => _QuillCustomToolBarState();
}

class _QuillCustomToolBarState extends State<QuillCustomToolBar> {
  QuillController get controller => widget.controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
          child: Row(
            children: [const Icon(Icons.font_download), Expanded(child: QFontFamilyButton(controller))],
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Row(
            children: [const Icon(Icons.font_download_outlined), Expanded(child: QFontFamilyButton(controller))],
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Row(
            children: [const Icon(Icons.text_fields_rounded), Expanded(child: QFontSizeButton(controller))],
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Row(
            children: [const Icon(Icons.format_line_spacing_rounded), Expanded(child: QLineHeightButton(controller))],
          ),
        ),
        textDecorationButtons(),
        alignAndListButtons(),
      ],
    );
  }

  Widget alignAndListButtons() {
    return SizedBox(
      height: 50.0,
      child: Row(
        children: [
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Row(
              children: [
                const Icon(Icons.text_format_outlined),
                SelectAlignmentButton(
                  controller: controller,
                  showCenterAlignment: true,
                  showJustifyAlignment: true,
                  showLeftAlignment: true,
                  showRightAlignment: true,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  const Icon(Icons.list),
                  ToggleStyleButton(
                    attribute: Attribute.ol,
                    controller: controller,
                    icon: Icons.format_list_numbered,
                  ),
                  ToggleStyleButton(
                    attribute: Attribute.ul,
                    controller: controller,
                    icon: Icons.format_list_bulleted,
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget textDecorationButtons() {
    return SizedBox(
      height: 50.0,
      child: Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  const Icon(Icons.font_download),
                  Row(
                    children: [
                      ToggleStyleButton(attribute: Attribute.bold, icon: Icons.format_bold, controller: controller),
                      ToggleStyleButton(attribute: Attribute.italic, icon: Icons.format_italic, controller: controller),
                      ToggleStyleButton(
                          attribute: Attribute.underline, icon: Icons.format_underline, controller: controller),
                      ToggleStyleButton(
                          attribute: Attribute.strikeThrough, icon: Icons.format_strikethrough, controller: controller),
                    ],
                  )
                ],
              ),
            ),
          ),
          // const Flexible(flex: 1, fit: FlexFit.loose, child: SizedBox.expand()),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.local_parking_sharp),
                  Row(
                    children: [
                      ToggleStyleButton(attribute: Attribute.script, icon: Icons.subscript, controller: controller),
                      ToggleStyleButton(attribute: Attribute.script, icon: Icons.superscript, controller: controller),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
