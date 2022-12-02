import 'package:components_demo/filter_pages_banner_demo/filter_pages_banner.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class FilterPagesBannerScreen extends StatefulWidget {
  const FilterPagesBannerScreen({super.key});

  @override
  State<FilterPagesBannerScreen> createState() => _FilterPagesBannerScreenState();
}

class _FilterPagesBannerScreenState extends State<FilterPagesBannerScreen> {
  List<int> pages = [1, 2, 3, 5, 6, 7, 9, 10, 14];
  int selectedPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Filter Pages Banner Demo"),
      bottomSheet: FilterPagesBanner(
        selectedPage: selectedPage,
        filterPages: pages,
        onPageChange: (newPage) {
          selectedPage = newPage;
          setState(() {});
        },
      ),
    );
  }
}
