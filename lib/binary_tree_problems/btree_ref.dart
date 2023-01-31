// import 'dart:math';

// class Node {
//   Node({required this.data, this.depth = 0});
//   int data;
//   int depth;
//   Node? left;
//   Node? right;

//   int get heightOfNode {
//     if (left == null && right == null) {
//       return 0;
//     } else {
//       return max(left?.heightOfNode ?? 0, right?.heightOfNode ?? 0) + 1;
//     }
//   }

//   Iterable<Node> get elements {
//     List<Node> list = [];
//     list.add(this);
//     if (left != null) list.addAll(left!.elements);
//     if (right != null) list.addAll(right!.elements);
//     return list;
//   }
// }

// class BinarySearchTree {
//   BinarySearchTree([List<int>? values]) {
//     if (values != null) insertAll(values);
//   }
//   Node? root;

//   List<Node> get elements {
//     if (root == null) return [];
//     return root!.elements.toList();
//   }

//   void insert(int data) {
//     Node newNode = Node(data: data);
//     newNode.data = data;
//     if (root == null) {
//       root = newNode;
//       root!.depth = 0;
//     } else {
//       _insert(root!, newNode);
//     }
//   }

//   void insertAll(Iterable<int> values) {
//     for (var element in values) {
//       insert(element);
//     }
//   }

//   List<int> preOrderTraverse() {
//     List<int> elements = [];
//     if (root == null)
//       return elements;
//     else
//       _preOrderTraverse(root!, elements);
//     return elements;
//   }

//   Map<int, int> nodeHeightMap() {
//     Map<int, int> depthMap = {};
//     if (root == null) return depthMap;
//     _nodeHeightMap(root!, depthMap);
//     return depthMap;
//   }

//   bool contains(int value) {
//     if (root == null) return false;
//     return _contains(root!, value);
//   }

//   void _insert(Node node, Node newNode) {
//     //Left
//     if (newNode.data < node.data) {
//       if (node.left != null) {
//         _insert(node.left!, newNode);
//       } else {
//         node.left = newNode;
//         node.left!.depth = node.depth + 1;
//       }
//     }
//     // right
//     else {
//       if (node.right != null) {
//         _insert(node.right!, newNode);
//       } else {
//         node.right = newNode;
//         node.right!.depth = newNode.depth + 1;
//       }
//     }
//   }

//   void _preOrderTraverse(Node node, List<int> elements) {
//     elements.add(node.data);
//     if (node.left != null) _preOrderTraverse(node.left!, elements);
//     if (node.right != null) _preOrderTraverse(node.right!, elements);
//   }

//   bool _contains(Node node, int value) {
//     if (node.data == value) return true;
//     if (value < node.data && node.left != null) {
//       return _contains(node.left!, value);
//     } else if (value >= node.data && node.right != null) {
//       return _contains(node.right!, value);
//     }
//     return false;
//   }

//   void _nodeHeightMap(Node node, Map<int, int> depthMap) {
//     depthMap[node.data] = node.heightOfNode;
//     if (node.left != null) _nodeHeightMap(node.left!, depthMap);
//     if (node.right != null) _nodeHeightMap(node.right!, depthMap);
//   }
// }

// class AVLTree extends BinarySearchTree {}

// void main(List<String> args) {
//   BinarySearchTree bTree = BinarySearchTree([12, 34, 56, 23, 45, 67, 887, 234, 1, 2, 43, 23, 13]);
//   // if (args.isNotEmpty) {
//   //   List<int> intArgs = [];
//   //   for (var element in args) {
//   //     int? value = int.tryParse(element);
//   //     if (value != null) {
//   //       intArgs.add(value);
//   //     }
//   //   }
//   //   bTree.insertAll(intArgs);
//   print(bTree.preOrderTraverse());
//   print(bTree.nodeHeightMap());
//   for (var element in bTree.elements) {
//     print("${element.data} : ${element.depth}");
//   }
//   // }
//   // bTree.insert(2);
//   // bTree.insert(16);
//   // bTree.insert(0);
//   // bTree.insert(8);
//   // print(bTree.preOrderTraverse());
//   // print(bTree.contains(8));
//   // print(bTree.contains(14));
// }

