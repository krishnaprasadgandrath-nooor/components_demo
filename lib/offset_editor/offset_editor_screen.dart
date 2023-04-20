import 'package:components_demo/offset_editor/offset_editor_component.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class OffsetEditorScreen extends StatefulWidget {
  const OffsetEditorScreen({super.key});

  @override
  State<OffsetEditorScreen> createState() => _OffsetEditorScreenState();
}

class _OffsetEditorScreenState extends State<OffsetEditorScreen> {
  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Offset Editor Demo"),
      body: Center(
        child: Column(
          children: [
            Text("$_offset"),
            AlignOffsetEditor(
              value: _offset,
              boundary: 10.0,
              onChanged: (x, y) => setState(() {
                _offset = Offset(x, y);
              }),
            )
          ],
        ),
      ),
    );
  }
}
