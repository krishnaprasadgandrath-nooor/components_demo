import 'dart:math';

abstract class Tree {
  final Node? root;

  Tree({
    this.root,
  });
  Iterable<int> get elements;
  Iterable<int> get preOrderElements;
  Iterable<int> get postOrderElements;
  Iterable<int> get inOrderElements;

  Iterable<Node> get nodes;

  void insert(int item);
  void insertAll(List<int> values);
  bool remove(int item);
}

class Node {
  final int value;
  Node? left;
  Node? right;

  Node({required this.value, this.left, this.right, this.level = 0});
  int get height => left == null && right == null ? 0 : 1 + max(left?.height ?? 0, right?.height ?? 0);

  int level;
  int get balanceFactor {
    int leftHeight = left == null ? 0 : (1 + left!.height);
    int rightHeight = right == null ? 0 : (1 + right!.height);
    return leftHeight - rightHeight;
  }

  ////Data Elements
  Iterable<int> get elements => [value, ...(left?.elements ?? []), ...(right?.elements ?? [])];
  Iterable<int> get preOrderElements => [value, ...(left?.elements ?? []), ...(right?.elements ?? [])];
  Iterable<int> get postOrderElements => [...(left?.elements ?? []), ...(right?.elements ?? []), value];
  Iterable<int> get inOrderElements => [...(left?.elements ?? []), value, ...(right?.elements ?? [])];

  Iterable<Node> get nodes => [this, ...(left?.nodes ?? []), ...(right?.nodes ?? [])];
}
