import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotatingCard extends StatefulWidget {
  const RotatingCard({super.key});

  @override
  State<RotatingCard> createState() => _RotatingCardState();
}

class _RotatingCardState extends State<RotatingCard> {
  double _angle = 0;
  Offset center = Offset.zero;
  Offset downPoint = Offset.zero;
  double? safeAngle;
  double changingAngle = 0;
  bool calculateObstuse = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Transform.rotate(
            angle: -(_angle) * (math.pi / 180),
            child: Column(
              children: [
                Container(height: 200, width: 200, color: Colors.orange),
                const SizedBox(
                    height: 15.0,
                    child: VerticalDivider(
                      color: Colors.black,
                    )),
                GestureDetector(
                    onPanDown: (details) {
                      RenderBox box = context.findRenderObject() as RenderBox;
                      Offset pos = box.localToGlobal(Offset.zero);
                      Size size = box.size;
                      center = Offset(pos.dx + (size.width / 2), pos.dy + (size.height / 2));
                      downPoint = details.globalPosition;
                      safeAngle = _angle;
                    },
                    onPanUpdate: (details) {
                      Offset updateOffset = details.globalPosition;
                      changingAngle = findAngle(center: center, downPoint: downPoint, dragPoint: updateOffset);
                      _angle = safeAngle! + changingAngle;
                      _angle = _angle % 360;
                      setState(() {});
                    },
                    onPanEnd: (details) {
                      safeAngle = null;
                      setState(() {});
                    },
                    child: Transform.rotate(angle: (_angle) * (math.pi / 180), child: Text("${_angle.floor()} °")))
              ],
            )),
        // Slider(
        //   value: _angle,
        //   onChanged: (value) => setState(() {
        //     _angle = value;
        //   }),
        //   min: 0.0,
        //   max: 360.0,
        // )
      ],
    );
  }

  // function find_angle(p0, p1, c) {
  //   var p0c = Math.sqrt(Math.pow(c.x - p0.x, 2) + Math.pow(c.y - p0.y, 2)); // p0->c (b)
  //   var p1c = Math.sqrt(Math.pow(c.x - p1.x, 2) + Math.pow(c.y - p1.y, 2)); // p1->c (a)
  //   var p0p1 = Math.sqrt(Math.pow(p1.x - p0.x, 2) + Math.pow(p1.y - p0.y, 2)); // p0->p1 (c)
  //   return Math.acos((p1c * p1c + p0c * p0c - p0p1 * p0p1) / (2 * p1c * p0c));
  // }

  ///Returns angle between given three points  wrt to center point
  double findAngle({required Offset downPoint, required Offset dragPoint, required Offset center}) {
    double downToCenter = (downPoint - center).distance; // p0->c (b)
    double centerToDrag = (center - dragPoint).distance; // p1->c (a)
    double downToDrag = (downPoint - dragPoint).distance; // p0->p1 (c)
    double angle = math.acos((centerToDrag * centerToDrag + downToCenter * downToCenter - downToDrag * downToDrag) /
        (2 * centerToDrag * downToCenter));
    double degrees = angle * (180 / math.pi);
    return degrees;
  }
}
