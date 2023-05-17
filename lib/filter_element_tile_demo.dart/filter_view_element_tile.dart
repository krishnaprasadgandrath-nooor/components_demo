// filter_view_element_tile.dart
import 'package:flutter/material.dart';

class FilterElementTile extends StatelessWidget {
  // final PDFElement type;
  final IconData? icon;
  final Text title;
  final Text trailing;
  final Text author;
  final bool showAuthor;
  final void Function()? goTo;
  final EdgeInsets padding;

  const FilterElementTile(
      {super.key,
      // required this.type,
      this.icon,
      required this.title,
      required this.trailing,
      required this.author,
      this.showAuthor = true,
      this.goTo,
      this.padding = const EdgeInsets.all(3.0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (icon != null) ...[
                const SizedBox(
                  width: 5,
                ),
                Icon(icon)
              ],
              const SizedBox(width: 5),
              title,
              const Spacer(),
              GestureDetector(onTap: goTo, child: trailing),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          if (showAuthor)
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              child: author,
            )
        ],
      ),
    );
  }
}
