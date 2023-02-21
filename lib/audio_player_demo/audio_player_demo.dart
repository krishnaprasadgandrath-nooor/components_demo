import 'package:audioplayers/audioplayers.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';

class AudioPlayerDemo extends StatefulWidget {
  const AudioPlayerDemo({super.key});

  @override
  State<AudioPlayerDemo> createState() => _AudioPlayerDemoState();
}

class _AudioPlayerDemoState extends State<AudioPlayerDemo> {
  TextEditingController audioUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "AudioPlayerDemo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextFormField(controller: audioUrlController)),
                MaterialButton(
                  onPressed: playFromUrl,
                  child: const Text("Play"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void playFromUrl() {
    String url = audioUrlController.text;
    if (url.isEmpty) return;
    Source source = url.startsWith('http') ? UrlSource(url) : DeviceFileSource(url);
    try {
      // AudioPlayer player = AudioPlayer();
      // player.setSource();

      AudioPlayer().play(source);
    } catch (e) {
      print("Errot while playing");
    }
  }
}
