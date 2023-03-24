import 'package:components_demo/demo_home.dart';

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
    return ProviderScope(
        child: MaterialApp(
      title: 'Flutter Demo',
      scrollBehavior: const ScrollBehavior().copyWith(dragDevices: {PointerDeviceKind.mouse}),
      theme: ThemeData(
        //

        primarySwatch: Colors.blue,
      ),
      home: const ComponentsHome(),
    ));
  }
}
