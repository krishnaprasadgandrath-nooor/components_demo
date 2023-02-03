import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:components_demo/binary_tree_problems/binary_tree.dart';
import 'package:components_demo/binary_tree_problems/tree_models.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/services.dart';

const double nodeSize = 40;

class TreeVisualizerScreen extends StatefulWidget {
  const TreeVisualizerScreen({super.key});

  @override
  State<TreeVisualizerScreen> createState() => _TreeVisualizerScreenState();
}

class _TreeVisualizerScreenState extends State<TreeVisualizerScreen> {
  late BTree bTree;

  final double levelGap = 50;
  final double siblingGap = 20;
  Map<Node, Offset> nodePosMap = {};

  int selectedIndex = 0;
  @override
  void initState() {
    initializeTree();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar.appBar(context, "Tree Demo Screen"),
        floatingActionButton: FloatingActionButton(onPressed: showInsertDialog),
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: InteractiveViewer(child: LayoutBuilder(
            builder: (context, constraints) {
              Size maxSize = constraints.biggest;
              Offset topCenter = Offset(maxSize.width / 2, 0);
              return SizedBox.fromSize(
                size: maxSize,
                child: CustomPaint(
                  painter: TreeLinePainter(nodePosMap: nodePosMap),
                  child: Stack(
                    children: [
                      if (bTree.root != null)
                        NodeTile(
                          position: Offset(topCenter.dx - nodeSize / 2, topCenter.dy),
                          nodeSize: nodeSize,
                          node: bTree.root!,
                          addToPosMap: addToPosMap,
                        ),
                      ...nodePosMap.entries
                          .map(
                            (e) => e.key.left != null
                                ? NodeTile(
                                    position:
                                        e.value + Offset(-siblingGap * (bTree.root!.height - e.key.level), levelGap),
                                    nodeSize: nodeSize,
                                    node: e.key.left!,
                                    addToPosMap: addToPosMap,
                                  )
                                : const SizedBox(
                                    height: nodeSize,
                                    width: nodeSize,
                                  ),
                          )
                          .toList(),
                      ...nodePosMap.entries
                          .map(
                            (e) => e.key.right != null
                                ? NodeTile(
                                    position:
                                        e.value + Offset(siblingGap * (bTree.root!.height - e.key.level), levelGap),
                                    nodeSize: nodeSize,
                                    node: e.key.right!,
                                    addToPosMap: addToPosMap)
                                : const SizedBox(
                                    height: nodeSize,
                                    width: nodeSize,
                                  ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              );
            },
          )),
        ));
  }

  void addToPosMap(entry) {
    if (nodePosMap[entry.key] == entry.value) return;
    nodePosMap[entry.key] = entry.value;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  void initializeTree() {
    bTree = BTree([12, 34, 56, 23, 45, 67, 887, 234, 1, 2, 43, 23, 13, 7]);

    print("Elements are : ${bTree.elements}");
    print("Tree Visualizer Rows : \n");
    List<List> treeDepthList = bTree.depthList;
    for (List row in treeDepthList) {
      for (var element in row) {
        print(element);
      }
      print("\n");
    }

    // Map<int, int> nodeHeights = {};
    // for (var element in bTree.nodes) {
    //   nodeHeights[element.value] = element.height;
    // }
    //   print("Heights Map of the tree is ${nodeHeights}");
    //   Map<int, int> nodeBalances = {};
    //   for (var element in bTree.nodes) {
    //     nodeBalances[element.value] = element.balanceFactor;
    //   }
    //   print("Balance Map of the tree is ${nodeBalances}");
    // }
  }

  Future<void> showInsertDialog() async {
    int? value = await showDialog<int>(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return Card(
            child: SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextField(
                        controller: controller,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, int.tryParse(controller.text)),
                          child: const Text("Insert")),
                    )
                  ],
                )));
      },
    );
    if (value != null) bTree.insert(value);
    setState(() {});
  }
}

class TreeLinePainter extends CustomPainter {
  Map<Node, Offset> nodePosMap;
  TreeLinePainter({
    required this.nodePosMap,
  });
  final Paint treeLinePaint = Paint();
  final Offset gapOff = const Offset(nodeSize / 2, nodeSize / 2);

  @override
  bool shouldRepaint(covariant TreeLinePainter oldDelegate) {
    return oldDelegate.nodePosMap.entries != nodePosMap.entries;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var element in nodePosMap.entries) {
      Node node = element.key;

      Offset nodeOffset = element.value;
      Offset? leftOffset = nodePosMap[node.left];
      Offset? rightOffset = nodePosMap[node.right];
      if (leftOffset != null) canvas.drawLine(nodeOffset + gapOff, leftOffset + gapOff, treeLinePaint);
      if (rightOffset != null) canvas.drawLine(nodeOffset + gapOff, rightOffset + gapOff, treeLinePaint);
    }
  }
}

class NodeTile extends StatelessWidget {
  const NodeTile({
    Key? key,
    required this.position,
    required this.nodeSize,
    required this.node,
    required this.addToPosMap,
    this.isRoot = false,
    this.shape = BoxShape.circle,
  }) : super(key: key);

  final Offset position;
  final double nodeSize;
  final Node node;
  final bool isRoot;
  final BoxShape shape;
  final void Function(MapEntry<Node, Offset>) addToPosMap;

  @override
  Widget build(BuildContext context) {
    addToPosMap(MapEntry(node, position));
    return AnimatedPositioned(
        duration: kThemeAnimationDuration,
        top: position.dy,
        left: position.dx,
        child: SizedBox(
          height: nodeSize,
          width: nodeSize,
          child: DecoratedBox(
            decoration:
                BoxDecoration(shape: shape, border: Border.all(width: 3, color: Colors.black), color: Colors.white),
            child: Center(
              child: Text("${node.value}"),
            ),
          ),
        ));
  }
}
