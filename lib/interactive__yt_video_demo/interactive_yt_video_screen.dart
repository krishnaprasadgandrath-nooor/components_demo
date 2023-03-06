import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

import 'interactive_yt_video_view.dart';

class InteractiveYTVideoScreen extends StatefulWidget {
  const InteractiveYTVideoScreen({super.key});

  @override
  State<InteractiveYTVideoScreen> createState() => _InteractiveYTVideoScreenState();
}

class _InteractiveYTVideoScreenState extends State<InteractiveYTVideoScreen> {
  final List<String> _interactiveVideoUrls = [];
  final TextEditingController _controller = TextEditingController();
  int _i = 1;
  bool videoScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "InteractiveVideoScreen"),
      body: videoScreen
          ? const Center(
              child: InteractiveYTVideoView(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: _interactiveVideoUrls
                      .map((e) => Text(
                            e,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ))
                      .toList(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("$_i/3"),
                ),
                TextField(
                  controller: _controller,
                  onEditingComplete: () {
                    final url = _controller.text;
                    _interactiveVideoUrls.add(url);
                    _i++;
                    if (_i == 4) videoScreen = true;

                    setState(() {});
                  },
                )
              ],
            ),
    );
  }
}
