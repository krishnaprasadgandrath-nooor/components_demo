import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IsolateDemoScreen extends StatefulWidget {
  const IsolateDemoScreen({super.key});

  @override
  State<IsolateDemoScreen> createState() => _IsolateDemoScreenState();
}

class _IsolateDemoScreenState extends State<IsolateDemoScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 100.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration.collapsed(hintText: "Paste Url"),
            ),
          ),
        ),
        ElevatedButton(onPressed: getImageAndCompute, child: const Text("Process"))
      ],
    );
  }

  void getImageAndCompute() {
    String url = _controller.text;
    Image image = Image.network(url);
  }
}
