import 'package:components_demo/binary_tree_problems/tree_models.dart';

class BSTree extends Tree {
  BSTree(List<int>? args) {
    if (args != null) {
      insertAll(args);
    }
  }

  @override
  Iterable<int> get elements => root?.elements ?? [];

  @override
  Iterable<int> get inOrderElements => root?.inOrderElements ?? [];

  @override
  Iterable<int> get postOrderElements => root?.postOrderElements ?? [];

  @override
  Iterable<int> get preOrderElements => root?.preOrderElements ?? [];

  @override
  Iterable<Node> get nodes => root?.nodes ?? [];

  @override
  bool remove(int item) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  void insert(int item) {
    Node node = Node(value: item);
    if (root == null) {
      root = node;
      // root ??= node;
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
