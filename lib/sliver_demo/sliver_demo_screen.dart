import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SliverDemoScreen extends StatefulWidget {
  const SliverDemoScreen({super.key});

  @override
  State<SliverDemoScreen> createState() => _SliverDemoScreenState();
}

class _SliverDemoScreenState extends State<SliverDemoScreen> {
  Set<int> selectedValues = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Sliver List Demo"),
      body: Column(
        children: [
          const ColoredBox(
            color: Colors.red,
            child: SizedBox(
                height: 50,
                child: Center(
                  child: Text("Heading"),
                )),
          ),
          Expanded(
              child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  floating: true,
                  snap: true,
                  actions: {
                    "Select All": () {
                      selectedValues.addAll([0, 1, 2, 3, 4, 5, 6]);
                      setState(() {});
                    },
                    "Reset": () {
                      selectedValues.clear();
                      setState(() {});
                    }
                  }
                      .entries
                      .map<Widget>((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: e.value,
                              child: Text(
                                e.key,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ))
                      .toList(),
                  bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 80.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 120.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150.0,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                mainAxisExtent: 30.0),
                            itemBuilder: (context, index) => Row(
                                  children: [
                                    Checkbox(
                                      value: selectedValues.contains(index),
                                      onChanged: (value) {
                                        selectedValues.contains(index)
                                            ? selectedValues.remove(index)
                                            : selectedValues.add(index);
                                        setState(() {});
                                      },
                                    ),
                                    Text(index.toString())
                                  ],
                                )),
                      ))),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Divider(),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0, mainAxisExtent: 150.0, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
                delegate: SliverChildBuilderDelegate(
                    childCount: 100,
                    (context, index) => Container(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "$index",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
              )
            ],
          ))
        ],
      ),
    );
  }
}
