import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class SliverDemoScreen extends StatefulWidget {
  const SliverDemoScreen({super.key});

  @override
  State<SliverDemoScreen> createState() => _SliverDemoScreenState();
}

class _SliverDemoScreenState extends State<SliverDemoScreen> {
  Set<int> selectedValues = {};
  Set<int> filteredValues = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Sliver List Demo"),
      body: Column(
        children: [
          const ColoredBox(
            color: Colors.grey,
            child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    "Heading",
                    style: TextStyle(color: Colors.white),
                  ),
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
                      selectedValues.addAll([1, 2, 3, 4, 5, 6]);
                      updateFilteredValues();
                      setState(() {});
                    },
                    "Reset": () {
                      selectedValues.clear();
                      updateFilteredValues();
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
                            itemBuilder: (context, index) {
                              int checkValue = index + 1;
                              return Row(
                                children: [
                                  Checkbox(
                                    value: selectedValues.contains(checkValue),
                                    onChanged: (value) {
                                      selectedValues.contains(checkValue)
                                          ? selectedValues.remove(checkValue)
                                          : selectedValues.add(checkValue);
                                      updateFilteredValues();
                                      setState(() {});
                                    },
                                  ),
                                  Text(checkValue.toString())
                                ],
                              );
                            }),
                      ))),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Divider(
                    thickness: 2.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Center(
                    child: Text("Selected Value are : "),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 0, maxHeight: 200.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                            color: Colors.red,
                            margin: const EdgeInsets.all(3.0),
                            child: Center(
                              heightFactor: 1.5,
                              child: Text(
                                "$index",
                                // "${selectedValues.elementAt((index))}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      itemCount: selectedValues.length * 5),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  child: Divider(
                    thickness: 2.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0, mainAxisExtent: 150.0, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
                delegate: SliverChildBuilderDelegate(
                    childCount: filteredValues.length,
                    (context, index) => Container(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "${filteredValues.elementAt(index)}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
              )
            ],
          )),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 6.0,
                  spreadRadius: 15.0,
                  color: const Color(0xff01FE0B).withAlpha(150),
                  offset: const Offset(0, 0),
                  blurStyle: BlurStyle.normal)
            ]),
            child: SizedBox(
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Mail", "Export", "Filter Mode"]
                    .map((e) => Container(
                          child: Center(
                            heightFactor: 1.2,
                            widthFactor: 2,
                            child: Text(e),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateFilteredValues() async {
    filteredValues.clear();
    for (var i = 1; i <= 1000; i++) {
      bool failed = false;
      for (var element in selectedValues) {
        if (i % element != 0) {
          failed = true;
          break;
        }
      }
      if (failed) continue;
      filteredValues.add(i);
      setState(() {});
    }
  }
}
