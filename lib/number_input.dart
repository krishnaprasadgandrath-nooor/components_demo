import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
  final String label;
  final double initialValue;
  final Function(double) onChanged;
  final double minValue;
  final double maxValue;

  const NumberInput({
    required this.label,
    required this.initialValue,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 1000,
  });

  @override
  _NumberInputState createState() => _NumberInputState();
}

class _NumberInputState<T> extends State<NumberInput> {
  late double _value;
  Timer? _timer;
  final _controller = TextEditingController();
  TextSelection _selection = TextSelection.collapsed(offset: 0);

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _controller.text = _value.toString();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(Function() callback) {
    _timer = Timer.periodic(Duration(milliseconds: 150), (_) {
      if (_value == widget.maxValue || _value == widget.minValue) _timer?.cancel();
      callback();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 3),
        DecoratedBox(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1), borderRadius: BorderRadius.circular(3.0)),
          child: Row(children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(border: InputBorder.none),
                  controller: _controller,
                  readOnly: true,
                  // onChanged: (value) {
                  //   _value = double.tryParse(value) ?? _value;
                  //   onValueChanged();
                  //   setState(() {});
                  // },
                ),
              ),
            ),
            SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Icon(Icons.add),
                    onTap: _value <= widget.maxValue
                        ? () {
                            _value++;
                            onValueChanged();
                            setState(() {});
                          }
                        : null,
                    onLongPressStart: _value <= widget.maxValue
                        ? (_) {
                            _startTimer(() {
                              _value++;
                              onValueChanged();
                              setState(() {});
                            });
                          }
                        : null,
                    onLongPressEnd: (_) {
                      _stopTimer();
                    },
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: const Icon(Icons.remove),
                    onTap: _value > widget.minValue
                        ? () {
                            _value--;
                            onValueChanged();
                            setState(() {});
                          }
                        : null,
                    onLongPressStart: _value > widget.minValue
                        ? (_) {
                            _startTimer(() {
                              _value--;
                              onValueChanged();
                              setState(() {});
                            });
                          }
                        : null,
                    onLongPressEnd: (_) {
                      _stopTimer();
                    },
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }

  void onValueChanged() {
    _controller.text = "$_value";
    _controller.selection = TextSelection.fromPosition(TextPosition(offset: _value.toString().length));
    widget.onChanged(_value);
  }
}
