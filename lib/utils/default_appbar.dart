import 'package:flutter/material.dart';

class DefaultAppBar {
  final String title;
  const DefaultAppBar({required this.title});

  static AppBar appBar(BuildContext context, String title, {bool noLeading = false}) {
    return AppBar(
      leading: !noLeading
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: Text(title),
    );
  }
}
