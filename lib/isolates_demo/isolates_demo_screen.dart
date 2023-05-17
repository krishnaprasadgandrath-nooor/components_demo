import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class IsolateDemoScreen extends StatefulWidget {
  const IsolateDemoScreen({super.key});

  @override
  State<IsolateDemoScreen> createState() => _IsolateDemoScreenState();
}

class _IsolateDemoScreenState extends State<IsolateDemoScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Image Feych ISolate Demo"),
      body: Column(
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
      ),
    );
  }

  void getImageAndCompute() {
    // String url = _controller.text;
    // Image image = Image.network(url);
  }
}
