import 'package:flutter/material.dart';

class BaseInterface {
  final bool isImplemented = false;
  void printData() {}
}

class BaseClass {
  void printBaseClassData() {
    debugPrint("This print is implemented from Base  Class");
  }
}

abstract class AbstractBase {
  void printAbstract();
}

class InterfaceDemo extends AbstractBase implements BaseInterface, BaseClass {
  @override
  void printData() {
    debugPrint("This print is implemented from Base  Interface");
  }

  @override
  bool isImplemented = false;

  @override
  void printBaseClassData() {
    debugPrint("This print is implemented from Base  Interface");
  }

  @override
  void printAbstract() {
    debugPrint("This print is implemented from Abstract Base  ");
  }
}
