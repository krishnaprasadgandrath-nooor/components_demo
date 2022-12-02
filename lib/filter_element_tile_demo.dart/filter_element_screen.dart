import 'package:components_demo/filter_element_tile_demo.dart/filter_view_element_tile.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class FilterElementScreen extends StatelessWidget {
  const FilterElementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Filter Element Demo"),
      body: const Center(
        child: FilterElementTile(title: Text("Title"), trailing: Text("Go TO"), author: Text("Author")),
      ),
    );
  }
}
