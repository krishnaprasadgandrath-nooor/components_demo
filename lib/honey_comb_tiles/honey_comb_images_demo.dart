import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class HoneyCombDemoScreen extends StatelessWidget {
  const HoneyCombDemoScreen({super.key});

  static const Map<String, Color> _colors = <String, Color>{
    '1': Colors.red,
    '2': Colors.green,
    '3': Colors.blue,
    '4': Colors.cyan,
    '5': Colors.purple,
    '6': Colors.pink,
    '7': Colors.black,
    '8': Colors.red,
    '9': Colors.green,
    '10': Colors.blue,
    '11': Colors.cyan,
    '12': Colors.purple,
    '13': Colors.pink,
    '14': Colors.black,
    '15': Colors.red,
    '16': Colors.green,
    '17': Colors.blue,
    '18': Colors.cyan,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Honey Comb Tile Demo"),
      body: Column(
        children: [
          // ColoredBox(
          //   color: Colors.black12,
          //   child: SizedBox(
          //     height: 300,
          //     width: 400,
          //     child: CustomMultiChildLayout(
          //       delegate: _CascadeLayoutDelegate(
          //         colors: _colors,
          //         overlap: 10.0,
          //         textDirection: Directionality.of(context),
          //       ),
          //       children: <Widget>[
          //         // Create all of the colored boxes in the colors map.
          //         for (MapEntry<String, Color> entry in _colors.entries)
          //           // The "id" can be any Object, not just a String.
          //           LayoutId(
          //             id: entry.key,
          //             child: Container(
          //               color: entry.value,
          //               width: 100.0,
          //               height: 100.0,
          //               alignment: Alignment.center,
          //               child: Text(entry.key),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(const Size(600, 600)),
                child: CustomMultiChildLayout(
                  delegate:
                      _HoneyCombDelegeate(ids: _colors.keys.toList(), hSpacing: 10.0, vSpacing: 10.0, maxHCount: 5),
                  children: _colors.entries
                      .map((e) => LayoutId(
                          id: e.key,
                          child: ClipPath(
                            clipper: HoneyCombTileClip(),
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/image_${_colors.keys.toList().indexOf(e.key) % 4}.png")),
                              ),
                            ),
                          )))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _HoneyCombDelegeate extends MultiChildLayoutDelegate {
  final List<dynamic> ids;
  final double hSpacing;
  final double vSpacing;
  final int maxHCount;
  final double? vExtent;

  _HoneyCombDelegeate({
    required this.ids,
    this.hSpacing = 10.0,
    this.vSpacing = 10.0,
    this.maxHCount = 2,
    this.vExtent,
  });

  // Perform layout will be called when re-layout is needed.
  @override
  void performLayout(Size size) {
    final double columnWidth = (size.width / maxHCount) - (hSpacing * (maxHCount - 1));
    // final verticalExtent = vExtent ?? columnWidth;

    Offset childPosition = Offset.zero;
    bool oddLine = true;
    int lineCount = 0;
    int noOfLines = 0;
    for (int i = 0; i < ids.length; i++) {
      // layoutChild must be called exactly once for each child.
      final id = ids[i];
      final Size currentSize = layoutChild(
        id,
        BoxConstraints(maxHeight: size.height, maxWidth: columnWidth),
      );

      // positionChild must be called to change the position of a child from
      // what it was in the previous layout. Each child starts at (0, 0) for the
      // first layout.
      positionChild(id, childPosition);
      lineCount++;
      if (oddLine ? lineCount >= maxHCount : lineCount >= (maxHCount - 1)) {
        oddLine = !oddLine;
        lineCount = 0;
        noOfLines++;
        final nextTop = ((currentSize.height * 0.75) * (noOfLines)) + (vSpacing * (noOfLines - 1));
        childPosition = oddLine
            ? Offset(0, nextTop + (vSpacing / 2))
            : Offset(0 + (currentSize.width + hSpacing) / 2, nextTop + (vSpacing / 2));
      } else {
        childPosition += Offset(currentSize.width + hSpacing, 0);
      }
    }
  }

  // shouldRelayout is called to see if the delegate has changed and requires a
  // layout to occur. Should only return true if the delegate state itself
  // changes: changes in the CustomMultiChildLayout attributes will
  // automatically cause a relayout, like any other widget.
  @override
  bool shouldRelayout(_HoneyCombDelegeate oldDelegate) => false;
}

class HoneyCombTileClip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    // TODO: implement getClip
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.lineTo(size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}


// class _CascadeLayoutDelegate extends MultiChildLayoutDelegate {
//   _CascadeLayoutDelegate({
//     required this.colors,
//     required this.overlap,
//     required this.textDirection,
//   });

//   final Map<String, Color> colors;
//   final double overlap;
//   final TextDirection textDirection;

//   // Perform layout will be called when re-layout is needed.
//   @override
//   void performLayout(Size size) {
//     final double columnWidth = size.width / colors.length;
//     Offset childPosition = Offset.zero;
//     switch (textDirection) {
//       case TextDirection.rtl:
//         childPosition += Offset(size.width, 0);
//         break;
//       case TextDirection.ltr:
//         break;
//     }
//     for (final String color in colors.keys) {
//       // layoutChild must be called exactly once for each child.
//       final Size currentSize = layoutChild(
//         color,
//         BoxConstraints(maxHeight: size.height, maxWidth: columnWidth),
//       );
//       // positionChild must be called to change the position of a child from
//       // what it was in the previous layout. Each child starts at (0, 0) for the
//       // first layout.
//       switch (textDirection) {
//         case TextDirection.rtl:
//           positionChild(color, childPosition - Offset(currentSize.width, 0));
//           childPosition += Offset(-currentSize.width, currentSize.height - overlap);
//           break;
//         case TextDirection.ltr:
//           positionChild(color, childPosition);
//           childPosition += Offset(currentSize.width, currentSize.height - overlap);
//           break;
//       }
//     }
//   }

//   // shouldRelayout is called to see if the delegate has changed and requires a
//   // layout to occur. Should only return true if the delegate state itself
//   // changes: changes in the CustomMultiChildLayout attributes will
//   // automatically cause a relayout, like any other widget.
//   @override
//   bool shouldRelayout(_CascadeLayoutDelegate oldDelegate) {
//     return oldDelegate.textDirection != textDirection || oldDelegate.overlap != overlap;
//   }
// }