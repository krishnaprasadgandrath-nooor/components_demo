import 'package:flutter/material.dart';

class ImageComponent extends StatefulWidget {
  final String image;
  const ImageComponent({super.key, required this.image});

  @override
  State<ImageComponent> createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Image.network(widget.image, fit: BoxFit.cover, width: 300, height: 250);
  }
}
