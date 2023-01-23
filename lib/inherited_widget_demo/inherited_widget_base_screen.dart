import 'package:components_demo/inherited_widget_demo/counter_state.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class InheritedWidgetScreen extends StatefulWidget {
  const InheritedWidgetScreen({super.key});

  @override
  State<InheritedWidgetScreen> createState() => _InheritedWidgetScreenState();
}

class _InheritedWidgetScreenState extends State<InheritedWidgetScreen> {
  int _count = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Inherited Widget Demo"),
      body: Center(
        child: CounterState(
            count: _count,
            increment: () {
              _count++;
              setState(() {});
            },
            decrement: () {
              _count--;
              setState(() {});
            },
            child: const InheritedChildWidget()),
      ),
    );
  }
}

class InheritedChildWidget extends StatelessWidget {
  const InheritedChildWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Text("Current Count is ${CounterState.of(context)?.count}"),
          ),
          Row(
            children: {
              "+": CounterState.of(context)?.increment,
              "-": CounterState.of(context)?.decrement,
            }
                .entries
                .map((e) => ElevatedButton(onPressed: e.value != null ? () => e.value!() : null, child: Text(e.key)))
                .toList(),
          )
        ],
      ),
    );
  }
}
