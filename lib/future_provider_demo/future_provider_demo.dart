import 'dart:math';

import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

StateProvider<String> updateProvider = StateProvider(
  (ref) => "Hello",
);
FutureProvider<int?> futureProvider = FutureProvider(
  (ref) async {
    ref.watch(updateProvider);
    await Future.delayed(const Duration(seconds: 5));
    return Random().nextInt(100);
  },
);

class FutureProviderScreen extends StatelessWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Future Provider Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, child) {
              var futurePro = ref.watch(futureProvider);
              return futurePro.map(
                data: (data) => Column(
                  children: [
                    Center(
                      child: Text("${data.value}"),
                    ),
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
