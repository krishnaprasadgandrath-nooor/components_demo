import 'dart:math';

import 'package:components_demo/selective_provider/custom_provider.dart';
import 'package:components_demo/utils/default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomProviderDemoScreen extends ConsumerWidget {
  const CustomProviderDemoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void changeTitle() {
      ref.read(customoProvider).updateData(newTitle: "Title${Random().nextInt(1000)}");
    }

    void changeInt() {
      ref.read(customoProvider).updateData(newRandomInt: Random().nextInt(2000));
    }

    void changeColor() {
      ref.read(customoProvider).updateData(newColor: Colors.accents[Random().nextInt(Colors.accents.length)]);
    }

    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "Custom PRovider Demo"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ColorWidget(),
            const TitleWidget(),
            const CountWidget(),
            const ListenerWidget(),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              spacing: 10.0,
              runSpacing: 10.0,
              children: {
                "Color": changeColor,
                "Title": changeTitle,
                "Int": changeInt,
                "Color and title": () {
                  changeColor();
                  changeTitle();
                },
                "Color and Int": () {
                  changeColor();
                  changeInt();
                },
                "Title and Int": () {
                  changeTitle();
                  changeInt();
                },
                "All": () {
                  changeColor();
                  changeTitle();
                  changeInt();
                }
              }
                  .entries
                  .map((e) => Container(
                        // color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: e.value, child: Text(e.key)),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class ColorWidget extends ConsumerStatefulWidget {
  const ColorWidget({super.key});

  @override
  ConsumerState<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends ConsumerState<ColorWidget> {
  @override
  Widget build(BuildContext context) {
    Color customProColor = ref.watch(customoProvider.select((value) => value.color));
    // String title = ref.watch(customoProvider.select((value) => value.title));

    print("Color Widget built");
    return Container(
      height: 200,
      color: Colors.accents[Random().nextInt(Colors.accents.length)],
      child: Center(
        child: Container(height: 30, width: 30, color: customProColor),
      ),
    );
  }
}

class TitleWidget extends ConsumerStatefulWidget {
  const TitleWidget({super.key});

  @override
  ConsumerState<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends ConsumerState<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    String customProTitle = ref.watch(customoProvider.select((value) => value.title));
    print("Title Widget built");
    return Container(
      height: 200,
      color: Colors.accents[Random().nextInt(Colors.accents.length)],
      child: Center(
        child: Container(
          height: 30,
          width: 30,
          child: Text(customProTitle),
        ),
      ),
    );
  }
}

class CountWidget extends ConsumerStatefulWidget {
  const CountWidget({super.key});

  @override
  ConsumerState<CountWidget> createState() => _CountWidgetState();
}

class _CountWidgetState extends ConsumerState<CountWidget> {
  @override
  Widget build(BuildContext context) {
    int customProInt = ref.watch(customoProvider.select((value) => value.randomInt));
    print("Count Widget built");
    return Container(
      height: 200,
      color: Colors.accents[Random().nextInt(Colors.accents.length)],
      child: Center(
        child: Container(
          height: 30,
          width: 30,
          child: Center(
            child: Text("$customProInt"),
          ),
        ),
      ),
    );
  }
}

class ListenerWidget extends ConsumerStatefulWidget {
  const ListenerWidget({super.key});

  @override
  ConsumerState<ListenerWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends ConsumerState<ListenerWidget> {
  Color _color = Colors.red;
  @override
  void initState() {
    ref.read(customoProvider).addListener(_listerToPro);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.accents[Random().nextInt(Colors.accents.length)], height: 20);
  }

  void _listerToPro() {
    // Color color = ref.read(customoProvider).color;
    // if (_color != color) {
    //   _color = color;
    if (mounted) setState(() {});
    // }
  }
}
