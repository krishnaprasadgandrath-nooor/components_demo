import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class MyAnimatedList extends StatefulWidget {
  const MyAnimatedList({super.key});

  @override
  State<MyAnimatedList> createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Aniamted List"),
      body: const CustomScrollView(),
      //   body: AnimatedListView(
      //     itemCount: 50,
      //     itemExtent: 100.0,
      //     itemBuilder: (context, index) => TweenAnimationBuilder(
      //       tween: Tween(begin: const Offset(0, 100), end: Offset.zero),
      //       duration: const Duration(seconds: 1),
      //       builder: (context, value, child) => Container(
      //         constraints: const BoxConstraints(maxHeight: 50.0),
      //         color: Colors.accents[index % Colors.accents.length],
      //         child: Center(
      //           child: Text(
      //             "Item $index ",
      //             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
