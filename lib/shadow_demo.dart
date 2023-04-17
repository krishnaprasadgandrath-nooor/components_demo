// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ShadowDemo extends StatelessWidget {
  const ShadowDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
          child: DecoratedBox(
              position: DecorationPosition.background,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.inner,
                      color: Colors.red.withAlpha(100),
                      blurRadius: 3.0,
                      offset: Offset(-3, -3)),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: -12.0,
                    blurRadius: 12.0,
                  ),
                ],
              ),
              child: const SizedBox(
                height: 200,
                width: 200,
                child: Card(),
              ))),
    );
  }
}
