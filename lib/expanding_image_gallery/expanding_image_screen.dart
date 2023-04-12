import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class ExpandingImageGalleryScreen extends StatefulWidget {
  const ExpandingImageGalleryScreen({super.key});

  @override
  State<ExpandingImageGalleryScreen> createState() => _ExpandingImageGalleryScreenState();
}

class _ExpandingImageGalleryScreenState extends State<ExpandingImageGalleryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Expanding Image Hover"),
      body: Center(
        child: DecoratedBox(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: SizedBox(
              height: 200,
              width: 300,
              child: ExpandOnHover(assetPaths: List.generate(4, (index) => "assets/image_$index.png")),
            )),
      ),
    );
  }
}

class ExpandOnHover extends StatefulWidget {
  final List<String> assetPaths;
  const ExpandOnHover({super.key, required this.assetPaths});

  @override
  State<ExpandOnHover> createState() => _ExpandOnHoverState();
}

class _ExpandOnHoverState extends State<ExpandOnHover> {
  int? _hoveredIndex;

  double hoveredWidth = 0;
  double unhoveredWidth = 0;
  double tWidth = 0;
  double tHeight = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        tWidth = constraints.biggest.width;
        tHeight = constraints.biggest.height;
        hoveredWidth = tWidth * 0.6;
        if (_hoveredIndex != null) {
          unhoveredWidth = (tWidth - hoveredWidth) / 3;
        } else {
          unhoveredWidth = tWidth / 4;
        }
        return Row(
            children: List.generate(widget.assetPaths.length, (index) => index)
                .map((e) => sizedImage(e, _hoveredIndex == e))
                .toList());
      },
    );
  }

  Widget sizedImage(int index, bool isHovered) {
    return MouseRegion(
      onEnter: (event) => updateHovered(index),
      onExit: (event) => checkAndRemoveHovered(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeIn,

        color: Colors.accents[index],
        width: isHovered ? hoveredWidth : unhoveredWidth,
        height: double.maxFinite,
        clipBehavior: Clip.antiAlias,
        // child: OverflowBox(
        //   alignment: Alignment.center,
        //   minHeight: tHeight,
        //   minWidth: tWidth,
        //   maxHeight: tHeight,
        //   maxWidth: tWidth,
        child: SizedBox(
          height: tHeight,
          width: tWidth,
          child: Image(
            image: AssetImage(widget.assetPaths[index]),
            fit: BoxFit.cover,
          ),
        ),
        // ),
      ),
    );
  }

  void checkAndRemoveHovered(int index) {
    if (_hoveredIndex == index) {
      _hoveredIndex = null;
      setState(() {});
    }
  }

  void updateHovered(int index) {
    if (_hoveredIndex != index) {
      _hoveredIndex = index;
      setState(() {});
    }
  }
}
