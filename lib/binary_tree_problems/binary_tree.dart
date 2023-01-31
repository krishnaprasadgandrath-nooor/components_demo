import 'package:components_demo/binary_tree_problems/tree_models.dart';

class BTree extends Tree {
  @override
  Node? root;

  @override
  Iterable<int> get elements => root?.elements ?? [];

  @override
  Iterable<Node> get nodes => root?.nodes ?? [];

  @override
  Iterable<int> get inOrderElements => root?.inOrderElements ?? [];

  @override
  Iterable<int> get postOrderElements => root?.postOrderElements ?? [];

  @override
  Iterable<int> get preOrderElements => root?.preOrderElements ?? [];

  @override
  bool remove(int data) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  BTree(List<int>? args) {
    if (args != null) {
      insertAll(args);
    }
  }

  @override
  void insert(int item) {
    Node node = Node(value: item);
    if (root == null) {
      root ??= node;
    } else {
      _insert(root!, node);
    }
  }

  @override
  void insertAll(Iterable<int> values) {
    for (var element in values) {
      insert(element);
    }
  }

  void _insert(Node parent, Node newNode) {
    ///Adding right
    if (parent.value <= newNode.value) {
      if (parent.right != null) {
        _insert(parent.right!, newNode);
      } else {
        parent.right = newNode;
      }
    }

    ///Adding Left
    else {
      if (parent.left != null) {
        _insert(parent.left!, newNode);
      } else {
        parent.left = newNode;
      }
    }
  }
}
