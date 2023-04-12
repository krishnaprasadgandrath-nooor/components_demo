import 'dart:math' as math;

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class AnimatedSwitchScreen extends StatefulWidget {
  const AnimatedSwitchScreen({super.key});

  @override
  State<AnimatedSwitchScreen> createState() => _AnimatedSwitchScreenState();
}

class _AnimatedSwitchScreenState extends State<AnimatedSwitchScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Aniamted Switch Demo"),
      backgroundColor: Colors.grey.shade200,
      body: const Center(
        child: SizedBox(height: 80, width: 200, child: AnimatedSwitch()),
      ),
    );
  }
}

class AnimatedSwitch extends StatefulWidget {
  const AnimatedSwitch({super.key});

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch> with SingleTickerProviderStateMixin {
  final duration = const Duration(milliseconds: 500);
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: duration, reverseDuration: duration, lowerBound: 0, upperBound: 1.0);
  late final Animation<double> _anim =
      CurvedAnimation(parent: _controller, curve: Curves.easeInCirc, reverseCurve: Curves.linearToEaseOut);

  bool isOn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(40.0),
        splashColor: Colors.white10,
        onTap: toggleState,
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(200, 100)),
          child: Stack(
            children: [
              //Bg
              AnimatedContainer(
                duration: duration,
                color: isOn ? Colors.greenAccent[400] : Colors.redAccent[400],
                child: const SizedBox.expand(),
              ),

              AnimatedPositioned(
                duration: duration,
                left: isOn ? 120 : 0,
                height: 80,
                width: 80,
                child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: AnimatedBuilder(
                      animation: _anim,
                      builder: (context, child) => Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..rotateY(((_anim.value > 0.8 ? 0.8 : _anim.value) / 2) * math.pi),
                          child: child),
                      child: AnimatedContainer(
                        duration: duration,
                        decoration:
                            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(isOn ? 20.0 : 80.0)),
                        child: SizedBox.expand(
                          child: FractionallySizedBox(
                              heightFactor: 0.7,
                              widthFactor: 0.7,
                              child: AnimatedBuilder(
                                animation: _anim,
                                builder: (context, child) =>
                                    Transform.scale(scaleX: 1 - _anim.value, scaleY: 1 - _anim.value, child: child),
                                child: AnimatedContainer(
                                  duration: duration,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(isOn ? 0.0 : 80.0),
                                    color: isOn ? Colors.greenAccent[400] : Colors.redAccent[400],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  toggleState() {
    isOn = !isOn;
    isOn ? _controller.forward() : _controller.reverse();
    setState(() {});
  }
}
