import 'dart:math';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

StateProvider<String> updateProvider = StateProvider(
  (ref) => "Hello",
);
StreamProvider<int?> streamProvider = StreamProvider(
  (ref) async* {
    List<int> bytees = [];
    ref.watch(updateProvider);
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // if (result != null && result.files.isNotEmpty) {
    //  result.files.first.readStream.forEach((element) { })
    // }

    for (var i = 0; i < 10; i++) {
      yield i;
      await Future.delayed(Duration(seconds: i));
    }
  },
);

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Stream Provider Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, child) {
              var futurePro = ref.watch(streamProvider);
              return futurePro.map(
                data: (data) => Column(
                  children: [
                    Text("${data.value}"),
                    // StreamBuilder(
                    //   stream: data as Stream,
                    //   builder: (context, snapshot) {
                    //     return Image.memory(snapshot.data);
                    //   },
                    // ),
                    ElevatedButton(
                        onPressed: () {
                          ref.read(updateProvider.state).state = Uuid().v1();
                        },
                        child: child)
                  ],
                ),
                error: (error) => const Center(
                  child: Text("Error While Loading Data"),
                ),
                loading: (loading) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
