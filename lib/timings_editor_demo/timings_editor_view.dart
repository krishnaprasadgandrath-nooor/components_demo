import 'package:components_demo/interactive__yt_video_demo/simple_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimingsEditor extends StatefulWidget {
  final Function(Duration startTime, Duration endTime) onTimeChanged;
  final Duration initialStartTime;
  final Duration initialEndTime;

  const TimingsEditor({
    Key? key,
    required this.onTimeChanged,
    required this.initialStartTime,
    required this.initialEndTime,
  }) : super(key: key);

  @override
  TimingsEditorState createState() => TimingsEditorState();
}

class TimingsEditorState extends State<TimingsEditor> {
  late int _startHours;
  late int _startMinutes;
  late int _startSeconds;
  late int _endHours;
  late int _endMinutes;
  late int _endSeconds;

  Duration get totalDuration =>
      Duration(hours: _endHours, minutes: _endMinutes, seconds: _endSeconds) -
      Duration(hours: _startHours, minutes: _startMinutes, seconds: _startSeconds);

  @override
  void initState() {
    super.initState();
    _startHours = widget.initialStartTime.inHours;
    _startMinutes = widget.initialStartTime.inMinutes.remainder(60);
    _startSeconds = widget.initialStartTime.inSeconds.remainder(60);
    _endHours = widget.initialEndTime.inHours;
    _endMinutes = widget.initialEndTime.inMinutes.remainder(60);
    _endSeconds = widget.initialEndTime.inSeconds.remainder(60);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("start :"),
      Row(
        children: [
          //Start Hours
          _CustomTimeEditField(
            value: _startHours,
            onChanged: (value) {
              final hours = _parseInputValue(value);
              setState(() {
                _startHours = hours;
              });
              _notifyTimeChanged();
            },
            isAtMinimun: _startHours <= 0,
            isAtMaximum: _startHours >= 12,
            onIncreased: () => {_startHours++, setState(() {})},
            onDecreased: () => {_startHours--, setState(() {})},
          ),
          const SizedBox(width: 8),
          //Start Minutes
          _CustomTimeEditField(
            value: _startMinutes,
            onChanged: (value) {
              final minutes = _parseInputValue(value);
              setState(() {
                _startMinutes = minutes;
              });
              _notifyTimeChanged();
            },
            isAtMinimun: _startMinutes <= 0,
            isAtMaximum: _startMinutes >= 60,
            onIncreased: () => {_startMinutes++, setState(() {})},
            onDecreased: () => {_startMinutes--, setState(() {})},
          ),
          const SizedBox(width: 8),
          //Start seconds
          _CustomTimeEditField(
            value: _startSeconds,
            onChanged: (value) {
              final seconds = _parseInputValue(value);
              setState(() {
                _startSeconds = seconds;
              });
              _notifyTimeChanged();
            },
            isAtMinimun: _startSeconds <= 0,
            isAtMaximum: _startSeconds >= 60,
            onIncreased: () => {_startSeconds++, setState(() {})},
            onDecreased: () => {_startSeconds--, setState(() {})},
          ),
        ],
      ),

      const SizedBox(width: 16),
      const Text("end :"),
      //End Hours

      Row(
        children: [
          _CustomTimeEditField(
            value: _endHours,
            onChanged: (value) {
              final hours = _parseInputValue(value);
              setState(() {
                _endHours = hours;
              });
              _notifyTimeChanged();
            },
            isAtMinimun: _endHours <= 0,
            isAtMaximum: _endHours >= 12,
            onIncreased: () => {_endHours++, setState(() {})},
            onDecreased: () => {_endHours--, setState(() {})},
          ),
          const SizedBox(width: 8),
          //End Minutes
          _CustomTimeEditField(
            value: _endMinutes,
            onChanged: (value) {
              final minutes = _parseInputValue(value);
              setState(() {
                _endMinutes = minutes;
              });
              _notifyTimeChanged();
            },
            isAtMinimun: _endMinutes <= 0,
            isAtMaximum: _endMinutes >= 60,
            onIncreased: () => {_endMinutes++, setState(() {})},
            onDecreased: () => {_endMinutes--, setState(() {})},
          ),
          const SizedBox(width: 8),
          //End Seconds
          _CustomTimeEditField(
            value: _endSeconds,
            onChanged: (value) {
              final seconds = _parseInputValue(value);
              setState(() {
                _endSeconds = seconds;
              });
              _notifyTimeChanged();
            },
            isAtMinimun: _endSeconds <= 0,
            isAtMaximum: _endSeconds >= 60,
            onIncreased: () => {_endSeconds++, setState(() {})},
            onDecreased: () => {_endSeconds--, setState(() {})},
          ),
        ],
      ),
      const SizedBox(height: 8),
      const Text("total Duration :"),
      Text(
        totalDuration.toHHMMSS,
        style: TextStyle(color: totalDuration < Duration.zero ? Colors.red : null),
      )
    ]);
  }

  int _parseInputValue(String value) {
    return int.tryParse(value) ?? 0;
  }

  void _notifyTimeChanged() {
    Duration startTime = Duration(hours: _startHours, minutes: _startMinutes, seconds: _startSeconds);
    Duration endTime = Duration(hours: _endHours, minutes: _endMinutes, seconds: _endSeconds);
    if (endTime < startTime) {
    } else {
      widget.onTimeChanged(startTime, endTime);
    }
  }

  // String _formatInputValue(int value) {
  //   return value.toString();
  // }
}

class _CustomTimeEditField extends StatelessWidget {
  final int value;
  final void Function(String value) onChanged;
  final bool isAtMinimun;
  final bool isAtMaximum;
  final void Function() onIncreased;
  final void Function() onDecreased;
  const _CustomTimeEditField({
    required this.value,
    required this.onChanged,
    required this.isAtMinimun,
    required this.isAtMaximum,
    required this.onIncreased,
    required this.onDecreased,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(3.0), border: Border.all(color: Colors.black54, width: 1)),
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(const Size(40, 40)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 2),
            Expanded(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: "$value"),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(2),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(2),
                ],
                onChanged: onChanged,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: isAtMaximum ? null : onIncreased,
                  child: const Icon(Icons.arrow_drop_up_outlined, size: 15.0),
                ),
                InkWell(
                  onTap: isAtMinimun ? null : onDecreased,
                  child: const Icon(Icons.arrow_drop_down_outlined, size: 15.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
