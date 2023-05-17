import 'dart:developer';

import 'package:components_demo/binary_tree_problems/binary_tree.dart';

void main(List<String> args) {
  BTree bTree = BTree([12, 34, 56, 23, 45, 67, 887, 234, 1, 2, 43, 23, 13]);

  log("Elements are : ${bTree.elements}");
  Map<int, int> nodeHeights = {};
  for (var element in bTree.nodes) {
    nodeHeights[element.value] = element.height;
  }
  log("Heights Map of the tree is $nodeHeights");
  Map<int, int> nodeBalances = {};
  for (var element in bTree.nodes) {
    nodeBalances[element.value] = element.balanceFactor;
  }
  log("Balance Map of the tree is $nodeBalances");

  // if (args.isNotEmpty) {
  //   List<int> intArgs = [];
  //   for (var element in args) {
  //     int? value = int.tryParse(element);
  //     if (value != null) {
  //       intArgs.add(value);
  //     }
  //   }
  //   bTree.insertAll(intArgs);
  // log(bTree.preOrderTraverse());
  // log(bTree.nodeHeightMap());
  // for (var element in bTree.elements) {
  //   log("${element.data} : ${element.depth}");
  // }
  // }
  // bTree.insert(2);
  // bTree.insert(16);
  // bTree.insert(0);
  // bTree.insert(8);
  // log(bTree.preOrderTraverse());
  // log(bTree.contains(8));
  // log(bTree.contains(14));
}
