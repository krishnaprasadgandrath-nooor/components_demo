import 'package:flutter/material.dart';

import 'action_editor.dart';
import 'animation_editor.dart';
import 'comp_editing_controller.dart';
import 'format_editor.dart';
import 'size_duration_editor.dart';

class CompEditorView extends StatefulWidget {
  final CompEditingController editController;
  const CompEditorView({super.key, required this.editController});

  @override
  State<CompEditorView> createState() => _CompEditorViewState();
}

class _CompEditorViewState extends State<CompEditorView> with SingleTickerProviderStateMixin {
  // late final TabController _tabController = TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: const Offset(-4, 0), color: Colors.grey.withAlpha(100), blurRadius: 2.0, spreadRadius: 2.0),
      ]),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            SizeAndDurationEditor(),
            AnimationEditor(),
            ActionEditor(),
            FormatEditor(),
          ],
        ),
      ),
    );
  }
}
