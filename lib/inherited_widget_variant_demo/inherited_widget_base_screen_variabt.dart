import 'package:components_demo/inherited_widget_variant_demo/counter_state_variant.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class InheritedWidgetVariantScreen extends StatefulWidget {
  const InheritedWidgetVariantScreen({super.key});

  @override
  State<InheritedWidgetVariantScreen> createState() => _InheritedWidgetVariantScreenState();
}

class _InheritedWidgetVariantScreenState extends State<InheritedWidgetVariantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Inherited Widget Demo"),
      body: Center(
        child: CounterStateVariant(child: const InheritedChildVariantWidget()),
      ),
    );
  }
}

class InheritedChildVariantWidget extends StatelessWidget {
  const InheritedChildVariantWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Center(
            child: Text("Current Count is ${CounterStateVariant.of(context)?.count}"),
          ),
          Row(
            children: {
              "+": CounterStateVariant.of(context)?.increment,
              "-": CounterStateVariant.of(context)?.decrement,
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
