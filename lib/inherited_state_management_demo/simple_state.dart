import 'package:flutter/material.dart';

class SimpleState extends ChangeNotifier {
  String _userName = "";
  int _userAge = 0;
  Color _favColor = Colors.red;

  String get userName => _userName;
  int get userAge => _userAge;
  Color get favColor => _favColor;

  void updateUserPrefs({String? newName, int? newAge, Color? newColor}) {
    _userName = newName ?? _userName;
    _userAge = newAge ?? _userAge;
    _favColor = newColor ?? _favColor;
    notifyListeners();
  }
}
