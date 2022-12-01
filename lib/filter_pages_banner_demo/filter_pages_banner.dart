// filter_pages_banner.dart

import 'package:flutter/material.dart';

class FilterPagesBanner extends StatefulWidget {
  final int selectedPage;
  final EdgeInsets padding;
  final double borderRadius;
  final List<int> filterPages;
  final double height;
  final void Function(int newPage) onPageChange;

  const FilterPagesBanner({
    super.key,
    required this.selectedPage,
    required this.onPageChange,
    this.height = 100,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = 50.0,
    required this.filterPages,
  });

  @override
  State<FilterPagesBanner> createState() => _FilterPagesBannerState();
}

class _FilterPagesBannerState extends State<FilterPagesBanner> {
  int get selectedPage => widget.selectedPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(200),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          leftButton(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: widget.filterPages
                  .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
                            child: GestureDetector(
                              onTap: () => changeSelectedPage(e),
                              child: CircleAvatar(
                                backgroundColor: selectedPage == e ? Colors.blue : Colors.transparent,
                                child: Text(
                                  e.toString(),
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                            ),
                          )
                      //  Padding(
                      //   padding: widget.padding,
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     padding: EdgeInsets.all(8.0),
                      //     decoration:
                      //         e == selectedPage ? const BoxDecoration(color: Colors.blue, shape: BoxShape.circle) : null,
                      //     child: Center(
                      //       child: Text(
                      //         e.toString(),
                      //         style: TextStyle(color: Colors.grey),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      )
                  .toList(),
            ),
          ),
          rightButton()
        ],
      ),
    );
  }

  void changeSelectedPage(int page) {
    if (selectedPage != page) {
      widget.onPageChange(page);
    }
  }

  Widget rightButton() {
    return commonButtonBuilder(
        icon: Icons.chevron_right_rounded, onTap: toNextPage, enabled: widget.filterPages.last != selectedPage);
  }

  Widget leftButton() {
    return commonButtonBuilder(
        icon: Icons.chevron_left_rounded, onTap: toPrevPage, enabled: widget.filterPages.first != selectedPage);
  }

  Widget commonButtonBuilder({required bool enabled, required IconData icon, required void Function() onTap}) {
    return IconButton(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, color: enabled ? Colors.grey : Colors.grey.withOpacity(0.2)),
    );
  }

  void toNextPage() {
    widget.onPageChange(widget.filterPages[widget.filterPages.indexOf(selectedPage) + 1]);
  }

  void toPrevPage() {
    widget.onPageChange(widget.filterPages[widget.filterPages.indexOf(selectedPage) - 1]);
  }
}
