import 'dart:math';

import 'package:components_demo/interfaces_demo/vehicle_inheritance_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VehiclesDemoScreen extends StatefulWidget {
  const VehiclesDemoScreen({super.key});

  @override
  State<VehiclesDemoScreen> createState() => _VehiclesDemoScreenState();
}

class _VehiclesDemoScreenState extends State<VehiclesDemoScreen> {
  List<Vehicle> vehicles = [Car(), Bike()];
  late Vehicle selectedVehicle = vehicles.first;
  FocusNode stageFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    stageFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: stageFocusNode,
        autofocus: true,
        onKey: handleKeyEvent,
        child: Column(
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: vehicles
                    .map(
                      (e) => Positioned(
                          top: e.vehiclePos.dy,
                          left: e.vehiclePos.dx,
                          child: Transform.rotate(
                            angle: e.vehicleAngle * (pi / 180),
                            child: IconButton(
                                onPressed: () => updateSelectedVehicle(e),
                                icon: Icon(
                                  e.icon,
                                  color: selectedVehicle == e ? Colors.blue : Colors.grey,
                                )),
                          )),
                    )
                    .toList(),
              ),
            ),
            Row(
              children: {
                Icons.arrow_downward: moveSelectedVehicleForward,
                Icons.arrow_upward: moveSelectedVehicleBackward,
                Icons.arrow_left: turnSelectedVehicleLeft,
                Icons.arrow_right: turnSelectedVehicleRight,
                // Icons.restore: selectedVehicle.reset(),
              }.entries.map((e) => IconButton(onPressed: e.value, icon: Icon(e.key))).toList(),
            )
          ],
        ),
      ),
    );
  }

  void handleKeyEvent(RawKeyEvent value) {
    if (value is RawKeyDownEvent) {
      if (value.logicalKey == LogicalKeyboardKey.arrowUp) moveSelectedVehicleBackward();
      if (value.logicalKey == LogicalKeyboardKey.arrowDown) moveSelectedVehicleForward();
      if (value.logicalKey == LogicalKeyboardKey.arrowLeft) turnSelectedVehicleLeft();
      if (value.logicalKey == LogicalKeyboardKey.arrowRight) turnSelectedVehicleRight();
      if (value.isAltPressed && value.logicalKey == LogicalKeyboardKey.tab) {
        updateSelectedVehicle(vehicles.first == selectedVehicle ? vehicles.last : vehicles.first);
      }
    }
  }

  void moveSelectedVehicleForward() {
    selectedVehicle.forward();
    setState(() {});
  }

  void moveSelectedVehicleBackward() {
    selectedVehicle.backward();
    setState(() {});
  }

  void turnSelectedVehicleLeft() {
    selectedVehicle.turnLeft();
    setState(() {});
  }

  void turnSelectedVehicleRight() {
    selectedVehicle.turnRight();
    setState(() {});
  }

  void updateSelectedVehicle(Vehicle e) {
    selectedVehicle = e;
    setState(() {});
  }
}
