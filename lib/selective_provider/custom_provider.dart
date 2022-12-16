import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNotifier extends ChangeNotifier {
  Color color = Colors.black;
  String title = "asdas";
  int randomInt = 23;

  void updateData({Color? newColor, String? newTitle, int? newRandomInt}) {
    color = newColor ?? color;
    title = newTitle ?? title;
    randomInt = newRandomInt ?? randomInt;
    notifyListeners();
  }
}

ChangeNotifierProvider<CustomNotifier> customoProvider =
    ChangeNotifierProvider<CustomNotifier>((ref) => CustomNotifier());
