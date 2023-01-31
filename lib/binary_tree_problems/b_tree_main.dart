import 'package:components_demo/binary_tree_problems/binary_tree.dart';

void main(List<String> args) {
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

  // if (args.isNotEmpty) {
  //   List<int> intArgs = [];
  //   for (var element in args) {
  //     int? value = int.tryParse(element);
  //     if (value != null) {
  //       intArgs.add(value);
  //     }
  //   }
  //   bTree.insertAll(intArgs);
  // print(bTree.preOrderTraverse());
  // print(bTree.nodeHeightMap());
  // for (var element in bTree.elements) {
  //   print("${element.data} : ${element.depth}");
  // }
  // }
  // bTree.insert(2);
  // bTree.insert(16);
  // bTree.insert(0);
  // bTree.insert(8);
  // print(bTree.preOrderTraverse());
  // print(bTree.contains(8));
  // print(bTree.contains(14));
}
