import 'package:components_demo/binary_tree_problems/binary_tree.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class TreeVisualizerScreen extends StatefulWidget {
  const TreeVisualizerScreen({super.key});

  @override
  State<TreeVisualizerScreen> createState() => _TreeVisualizerScreenState();
}

class _TreeVisualizerScreenState extends State<TreeVisualizerScreen> {
  @override
  void initState() {
    initializeTree();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Tree Demo Screen"),
      floatingActionButton: FloatingActionButton(onPressed: initializeTree),
      body: const Center(
        child: Text("Tree Visualizer SCreen"),
      ),
    );
  }

  void initializeTree() {
    BTree bTree = BTree([12, 34, 56, 23, 45, 67, 887, 234, 1, 2, 43, 23, 13]);

    print("Elements are : ${bTree.elements}");
    Map<int, int> nodeHeights = {};
    for (var element in bTree.nodes) {
      nodeHeights[element.value] = element.height;
    }
    print("Heights Map of the tree is ${nodeHeights}");
    Map<int, int> nodeBalances = {};
    for (var element in bTree.nodes) {
      nodeBalances[element.value] = element.balanceFactor;
    }
    print("Balance Map of the tree is ${nodeBalances}");
  }
}
