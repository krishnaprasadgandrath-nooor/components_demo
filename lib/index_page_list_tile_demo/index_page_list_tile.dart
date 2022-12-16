import 'package:flutter/material.dart';

const Color bookmarksColor = Color.fromRGBO(58, 98, 190, 1);
const Color enrichmentsColor = Color.fromRGBO(169, 48, 196, 1);
const Color linksColor = Color.fromRGBO(56, 188, 147, 1);
const Color notesColor = Color.fromRGBO(247, 204, 80, 1);
const Color drawingColor = Color.fromRGBO(15, 110, 23, 1);
const Color annotationsColor = Color.fromRGBO(207, 0, 16, 1);

class IndexPageListTile extends StatelessWidget {
  final int pageNo;
  final bool isSelected;
  final bool isBookMark;
  final int enrichCount;
  final int linksCount;
  final int notesCount;
  final bool hasDrawing;
  final bool haveAnnotations;
  final double radius;

  const IndexPageListTile(
      {super.key,
      required this.pageNo,
      this.isSelected = false,
      this.isBookMark = false,
      this.enrichCount = 0,
      this.linksCount = 0,
      this.notesCount = 0,
      this.hasDrawing = false,
      this.haveAnnotations = false,
      this.radius = 20.0});

  final EdgeInsets _defaultMargin = const EdgeInsets.all(1.5);

  @override
  Widget build(BuildContext context) {
    // NTheme customTheme = Theme.of(context).extension<NTheme>()!;
    return Container(
      padding: const EdgeInsets.all(3.0),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        children: [
          ///BookMark And Title
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isBookMark ? iconTile(icon: Icons.bookmark_outline, color: bookmarksColor) : SizedBox(width: radius),
                Text("Page $pageNo")
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (enrichCount != 0) countTile(count: enrichCount, color: enrichmentsColor),
                if (linksCount != 0) countTile(count: linksCount, color: linksColor),
                if (notesCount != 0) countTile(count: notesCount, color: notesColor),
                if (hasDrawing) iconTile(icon: Icons.draw_outlined, color: drawingColor),
                if (haveAnnotations) iconTile(icon: Icons.align_horizontal_center_outlined, color: annotationsColor)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget iconTile({required IconData icon, Color color = Colors.black, double size = 15.0}) {
    return Container(
        margin: _defaultMargin,
        height: radius,
        width: radius,
        child: Icon(
          icon,
          color: color,
          size: size,
        ));
  }

  Widget countTile({required int count, required Color color}) {
    return Container(
      alignment: Alignment.center,
      margin: _defaultMargin,
      height: radius,
      width: radius,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(child: FittedBox(child: Text("$count", style: const TextStyle(color: Colors.white)))),
    );
  }
}
