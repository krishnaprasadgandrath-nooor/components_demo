import 'package:flutter/material.dart';

import 'default_appbar.dart';

class CompHolder extends StatefulWidget {
  final String? title;
  final Widget child;
  const CompHolder({super.key, required this.child, this.title});

  @override
  State<CompHolder> createState() => _CompHolderState();
}

class _CompHolderState extends State<CompHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFECACA),
      appBar: DefaultAppBar.appBar(context, widget.title ?? 'CompHolder Screen'),
      body: Center(
        child: widget.child,
      ),
    );
  }
}
