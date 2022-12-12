// vehicle_inheritance_demo.dart

import 'package:flutter/material.dart';

abstract class VehicleMovement {
  Offset vehiclePos = Offset.zero;
  double vehicleAngle = 0;

  void forward() {
    vehiclePos = Offset(vehiclePos.dx, vehiclePos.dy + 1);
  }

  void backward() {
    vehiclePos = Offset(vehiclePos.dx, vehiclePos.dy - 1);
  }

  void turnLeft();
  void turnRight();
}

class VehicleBluePrint {
  int noOfWheels = 2;
  int noOfGears = 1;
  bool isSteeringControl = false;
  IconData icon = Icons.flight;
}

class Vehicle extends VehicleMovement implements VehicleBluePrint {
  @override
  int noOfWheels = 2;
  @override
  int noOfGears = 1;
  @override
  bool isSteeringControl = false;
  @override
  IconData icon = Icons.flight;

  @override
  void turnLeft() {
    vehicleAngle = vehicleAngle - 90;
  }

  @override
  void turnRight() {
    vehicleAngle = vehicleAngle + 90;
  }
}

mixin Reset on VehicleMovement {
  reset() {
    vehiclePos = Offset.zero;
    vehicleAngle = 0;
  }
}

class Bike extends Vehicle implements VehicleBluePrint {
  @override
  IconData icon = Icons.pedal_bike;

  @override
  bool isSteeringControl = false;

  @override
  int noOfGears = 6;

  @override
  int noOfWheels = 2;

  @override
  void turnLeft() {
    vehicleAngle = vehicleAngle - 20;
  }

  @override
  void turnRight() {
    vehicleAngle = vehicleAngle + 20;
  }
}

class Car extends Vehicle implements VehicleBluePrint {
  @override
  IconData icon = Icons.car_crash;

  @override
  bool isSteeringControl = true;

  @override
  int noOfGears = 6;

  @override
  int noOfWheels = 4;

  @override
  void turnLeft() {
    vehicleAngle = vehicleAngle - 90;
  }

  @override
  void turnRight() {
    vehicleAngle = vehicleAngle + 90;
  }
}
