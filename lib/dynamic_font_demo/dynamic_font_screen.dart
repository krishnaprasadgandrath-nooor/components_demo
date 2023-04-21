import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DynamicFontScreen extends StatefulWidget {
  const DynamicFontScreen({super.key});

  @override
  State<DynamicFontScreen> createState() => _DynamicFontScreenState();
}

class _DynamicFontScreenState extends State<DynamicFontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Dynamic Font SCreen"),
      body: Column(
        children: [
          const Text(
            "Hello Buddy !!",
            style: TextStyle(fontFamily: 'rakkas'),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
              onPressed: () async {
                FontLoader loader = FontLoader('rakkas');
                Future<ByteData> fontdata =
                    fetchDynamicFont('https://files.semanoor.com/flutterfonts/fonts/Rakkas/Rakkas-Regular.ttf');
                loader.addFont(fontdata);
                loader.load();
                setState(() {});
              },
              child: const Text('Load'))
        ],
      ),
    );
  }

  Future<ByteData> fetchDynamicFont(String fonturl) async {
    final response = await http.get(Uri.parse(fonturl));
    if (response.statusCode == 200) {
      return ByteData.view(response.bodyBytes.buffer);
    } else {
      throw Exception('Failed to load font');
    }
  }
}
