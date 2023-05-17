import 'dart:developer';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class ScaleDemoScreen extends StatefulWidget {
  const ScaleDemoScreen({super.key});

  @override
  State<ScaleDemoScreen> createState() => _ScaleDemoScreenState();
}

class _ScaleDemoScreenState extends State<ScaleDemoScreen> {
  double scaleValue = 1.0;
  double initScale = 1.0;
  double updateScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Pinch Scaling Demo"),
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          color: Colors.green,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox.expand(
                child: GestureDetector(
                    onScaleStart: (details) {
                      initScale = scaleValue;
                    },
                    onScaleUpdate: (details) {
                      log("Scale :${details.scale}");
                      updateScale = initScale * details.scale;
                    },
                    onScaleEnd: (details) {
                      scaleValue = updateScale;
                      setState(() {});
                    },
                    child: Container(
                      color: Colors.orange,
                    )),
              ),
              Center(
                child: Transform.scale(
                    scale: scaleValue,
                    child: Container(
                        color: Colors.red,
                        height: 100,
                        width: 100,
                        child: const SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text('''
                      Farhan Tanvir
                      
                      in
                      
                      Geek Culture
                      
                      7 Flutter Open Source Projects to Become a Better Flutter Developer
                      
                      Nishant Aanjaney Jalan
                      Nishant Aanjaney Jalan
                      
                      in
                      
                      CodeX
                      
                      Do you follow these Kotlin Best Practices?
                      
                      Ben "The Hosk" Hosking
                      Ben "The Hosk" Hosking
                      
                      in
                      
                      ITNEXT
                      
                      The Difference Between The Clever Developer & The Wise Developer
                      
                      Asmae ziani
                      Asmae ziani
                      
                      Reverse Engineering and Analyzing Android Apps: A Step-by-Step Guide
                      
                      Help
                      
                      Status
                      
                      Writers
                      
                      Blog
                      
                      '''),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
