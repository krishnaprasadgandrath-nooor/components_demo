import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class MatrixTransformDemo extends StatefulWidget {
  const MatrixTransformDemo({super.key});

  @override
  State<MatrixTransformDemo> createState() => _MatrixTransformDemoState();
}

class _MatrixTransformDemoState extends State<MatrixTransformDemo> {
  final List<String> rows = ["a", "b", "c", "d"];
  final List<int> cols = [0, 1, 2, 3];
  Map<String, int> rowValue = {
    "a": 0,
    "b": 1,
    "c": 2,
    "d": 3,
  };
  Matrix4 _matrix4 = Matrix4.identity();

  Map<String, TextEditingController> controllers = {};

  GlobalKey contKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "MAtrix Transform Demo"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Center(
                child: AnimatedContainer(
                  key: contKey,
                  duration: const Duration(seconds: 1),
                  transformAlignment: Alignment.center,
                  alignment: Alignment.center,
                  transform: _matrix4,
                  child: const SizedBox(
                    height: 100,
                    width: 100,
                    child: ColoredBox(
                      color: Colors.black,
                      child: FlutterLogo(),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    DataTable(
                        columns: cols.map((e) => DataColumn(label: Text(e.toString()))).toList(),
                        border: TableBorder.all(color: Colors.black, borderRadius: BorderRadius.circular(3.0)),
                        rows: rows
                            .map((r) => DataRow(
                                cells: cols
                                    .map((c) => DataCell(TextField(
                                          controller: controllers["$r$c"],
                                          onEditingComplete: () {
                                            String value = controllers["$r$c"]!.text;
                                            updateMatrix(r, c, value);
                                          },
                                        )))
                                    .toList()))
                            .toList()),
                    Expanded(
                        child: Center(
                      child: Text("$_matrix4"),
                    ))
                  ],
                )),
            SizedBox(
              height: 50.0,
              child: Row(
                children: [IconButton(onPressed: resetAll, icon: Icon(Icons.replay))],
              ),
            )
          ],
        ),
      ),
    );
  }

  void initializeControllers() {
    for (var row in rows) {
      for (var col in cols) {
        controllers["$row$col"] = TextEditingController(text: "${_matrix4.entry(rowValue[row]!, col)}");
      }
    }
  }

  void updateMatrix(String row, int col, String value) {
    double nvalue = double.tryParse(value) ?? 0;
    _matrix4.setEntry(rowValue[row]!, col, nvalue);
    setState(() {});
  }

  void resetAll() {
    _matrix4 = Matrix4.identity();
    initializeControllers();
    setState(() {});
  }
}
