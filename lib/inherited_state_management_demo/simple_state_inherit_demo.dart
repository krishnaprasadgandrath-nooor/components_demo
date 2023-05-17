import 'package:components_demo/inherited_state_management_demo/name_changer_widget.dart';
import 'package:components_demo/inherited_state_management_demo/simple_inherit_widget.dart';
import 'package:components_demo/inherited_state_management_demo/simple_state.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class SimpleInheritStateDemoScreen extends StatefulWidget {
  const SimpleInheritStateDemoScreen({super.key});

  @override
  State<SimpleInheritStateDemoScreen> createState() => _SimpleInheritStateDemoScreenState();
}

class _SimpleInheritStateDemoScreenState extends State<SimpleInheritStateDemoScreen> {
  int viewIndex = 0;
  final SimpleState _state = SimpleState();
  @override
  void initState() {
    _state.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Simple State Inherit Demo"),
      body: Center(
        child: SimplInheritedWidget(
            simplState: _state,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Current Index : $viewIndex"),
                    IconButton(
                        onPressed: () {
                          viewIndex = viewIndex == 0
                              ? 1
                              : viewIndex == 1
                                  ? 2
                                  : 0;
                          setState(() {});
                        },
                        icon: const Icon(Icons.shuffle))
                  ],
                ),
                const NameChanger()
              ],
            )),
      ),
    );
  }
}
