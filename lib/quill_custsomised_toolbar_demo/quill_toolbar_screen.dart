import 'package:components_demo/quill_custsomised_toolbar_demo/quill_customised_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillToolbarScreen extends StatefulWidget {
  const QuillToolbarScreen({super.key});

  @override
  State<QuillToolbarScreen> createState() => _QuillToolbarScreenState();
}

class _QuillToolbarScreenState extends State<QuillToolbarScreen> {
  QuillController controller =
      QuillController(document: Document(), selection: const TextSelection.collapsed(offset: 0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: QuillEditor(
              controller: controller,
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              scrollable: true,
              padding: const EdgeInsets.all(8.0),
              autoFocus: true,
              readOnly: false,
              expands: false),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(300, double.infinity)),
          child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withAlpha(50), offset: const Offset(2, 0), blurRadius: 3.0, spreadRadius: 5.0)
              ]),
              child: QuillCustomToolBar(controller)),
        )
      ],
    ));
  }
}
