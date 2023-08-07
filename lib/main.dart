import 'package:components_demo/rect_illustion/rect_iluusion_home.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<double> valueNotifier = ValueNotifier(0.3);
    return ProviderScope(
        child: MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: const ScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse}),
      theme: ThemeData(
        //

        primarySwatch: Colors.blue,
      ),
      home: const RectIllusionHome(),
      // home: const RectangleWithLinesScreen(),
      // home: const FunvasScreen(),
      // home: CompHolder(  
      //   child: ColoredBox(
      //     color: Colors.yellow,
      //     child: ValueListenableBuilder<double>(
      //         valueListenable: valueNotifier,
      //         builder: (context, value, child) => LRotatedBox(
      //               angle: (180.0 * valueNotifier.value).toInt(),
      //               child: ColoredBox(
      //                 color: Colors.orange,
      //                 child: SizedBox(
      //                   width: 300,
      //                   height: 30,
      //                   child: Slider(value: value, onChanged: (newValue) => valueNotifier.value = newValue),
      //                 ),
      //               ),
      //             )),
      //   ),
      // ),
    ));
  }
}
