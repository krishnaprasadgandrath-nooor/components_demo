import 'package:components_demo/int_video_views/comp_editing_controller.dart';
import 'package:components_demo/int_video_views/int_video_edit_view.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class IntVideoEditScreen extends StatefulWidget {
  const IntVideoEditScreen({super.key});

  @override
  State<IntVideoEditScreen> createState() => _IntVideoEditScreenState();
}

class _IntVideoEditScreenState extends State<IntVideoEditScreen> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Int Video Edit Views Screen"),
      body: Stack(
        children: [
          SizedBox.expand(
            child: GestureDetector(
              onPanDown: (details) {
                isExpanded = !isExpanded;
                setState(() {});
              },
            ),
          ),
          if (isExpanded)
            Align(
              alignment: Alignment.centerRight,
              child: TweenAnimationBuilder(
                tween: Tween<Offset>(begin: const Offset(300, 0), end: Offset.zero),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) => Transform.translate(offset: value, child: child),
                child: ConstrainedBox(
                  constraints: const BoxConstraints.expand(height: double.maxFinite, width: 300),
                  child: CompEditorView(editController: CompEditingController()),
                ),
              ),
            )
        ],
      ),
    );
  }
}
