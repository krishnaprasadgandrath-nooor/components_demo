import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class CompPlaceHolder extends StatefulWidget {
  const CompPlaceHolder({super.key});

  @override
  State<CompPlaceHolder> createState() => _CompPlaceHolderState();
}

class _CompPlaceHolderState extends State<CompPlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Place Holder Screen"),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
