import 'package:components_demo/utils/default_appbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceInfoWebDemoScreen extends StatefulWidget {
  const DeviceInfoWebDemoScreen({super.key});

  @override
  State<DeviceInfoWebDemoScreen> createState() => _DeviceInfoWebDemoScreenState();
}

class _DeviceInfoWebDemoScreenState extends State<DeviceInfoWebDemoScreen> {
  // ignore: unused_field
  BaseDeviceInfo? _info;
  @override
  void initState() {
    getDeviceInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar.appBar(context, "DEvice Info Demo"),
    );
  }

  Future<void> getDeviceInfo() async {
    DeviceInfoPlugin dIPlugin = DeviceInfoPlugin();
    _info = await dIPlugin.deviceInfo;
    setState(() {});
  }
}
