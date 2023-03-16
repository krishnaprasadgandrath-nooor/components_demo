// import 'package:flutter/material.dart';

// class ImageCompView extends StatefulWidget {
//   final String image;

//   const ImageCompView(this.image, {super.key});

//   @override
//   State<ImageCompView> createState() => _ImageCompViewState();
// }

// class _ImageCompViewState extends State<ImageCompView> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: Image.network(
//       widget.image,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return const SizedBox.expand(
//           child: Center(
//             child: Text("Couldn't Load Image"),
//           ),
//         );
//       },
//     ));
//   }
// }
