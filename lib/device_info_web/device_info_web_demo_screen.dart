import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeviceInfoWebDemoScreen extends StatefulWidget {
  const DeviceInfoWebDemoScreen({super.key});

  @override
  State<DeviceInfoWebDemoScreen> createState() => _DeviceInfoWebDemoScreenState();
}

class _DeviceInfoWebDemoScreenState extends State<DeviceInfoWebDemoScreen> {
  BaseDeviceInfo? _info;
  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin dIPlugin = DeviceInfoPlugin();
    _info = await dIPlugin.deviceInfo;
    setState(() {});
  }
}
