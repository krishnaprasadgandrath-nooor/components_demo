import 'package:components_demo/number_input_demo/number_input.dart';

import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../timings_editor_demo/timings_editor_view.dart';

class SizeAndDurationEditor extends StatefulWidget {
  const SizeAndDurationEditor({super.key});

  @override
  State<SizeAndDurationEditor> createState() => _SizeAndDurationEditorState();
}

class _SizeAndDurationEditorState extends State<SizeAndDurationEditor> {
  double left = 0;
  double top = 0;
  double height = 0;
  double width = 0;
  Duration startDuration = Duration.zero;
  Duration endDuration = const Duration(minutes: 1, seconds: 30);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints.expand(height: 30, width: 300),
            color: Colors.black12,
            child: const Text(" Position And Size")),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(300, 80)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 120, height: 53),
                child: NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  isInt: false,
                  initialValue: 0,
                  onChanged: (value) {
                    left = value.toDouble();
                    updateSizeAndPosition();
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 120, height: 53),
                child: NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  isInt: false,
                  initialValue: 0,
                  onChanged: (value) {
                    top = value.toDouble();
                    updateSizeAndPosition();
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size(300, 80)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 120, height: 53),
                child: NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  isInt: false,
                  initialValue: 0,
                  onChanged: (value) {
                    width = value.toDouble();
                    updateSizeAndPosition();
                  },
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints.expand(width: 120, height: 53),
                child: NumberInputWithIncrementDecrement(
                  controller: TextEditingController(),
                  isInt: false,
                  initialValue: 0,
                  onChanged: (value) {
                    height = value.toDouble();
                    updateSizeAndPosition();
                  },
                ),
              )
            ],
          ),
        ),
        // ConstrainedBox(
        //   constraints: BoxConstraints.loose(const Size(300, 80)),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       ConstrainedBox(
        //         constraints: const BoxConstraints.expand(width: 120),
        //         child: NumberInputWithIncrementDecrement(
        //           isInt: false,
        //           controller: TextEditingController(),
        //           initialValue: 0,
        //           onChanged: (value) {
        //             left = value.toDouble();
        //             updateSizeAndPosition();
        //           },
        //         ),
        //       ),
        //       ConstrainedBox(
        //         constraints: const BoxConstraints.expand(width: 120),
        //         child: NumberInputWithIncrementDecrement(
        //           controller: TextEditingController(),
        //           initialValue: 0,
        //           isInt: false,
        //           onChanged: (value) {
        //             top = value.toDouble();
        //             updateSizeAndPosition();
        //           },
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        const SizedBox(height: 8),
        Container(
            alignment: Alignment.centerLeft,
            constraints: const BoxConstraints.expand(height: 30, width: 300),
            color: Colors.black12,
            child: const Text(" Duration")),
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size(300, 300)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TimingsEditor(
                onTimeChanged: updateDuration, initialStartTime: startDuration, initialEndTime: endDuration),
          ),
        )
      ],
    );
  }

  void updateSizeAndPosition() {}

  void updateDuration(Duration startTime, Duration endTime) {}
}
