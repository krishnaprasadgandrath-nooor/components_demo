import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:random_string/random_string.dart';

late Isolate isolate;

main() {
  print("running dart program");
  createNewIsolate();
}

void createNewIsolate() {
  ReceivePort receivePort = ReceivePort();
  Isolate.spawn(isolateMain, receivePort.sendPort).then((_isolate) {
    isolate = _isolate;
    print('isolate: $isolate');
    receivePort.listen((messages) {
      print('new message from ISOLATE $messages');
    });
  });
}

void isolateMain(SendPort sendPort) {
  int i = 0;
  Timer.periodic(const Duration(seconds: 2), (Timer t) {
    if (i == 5) exit(0);
    i += 1;

    sendPort.send('RANDOM STRING: ${randomString(10)}; RANDOM INTEGER: ${randomNumeric(10)}');
  });
}
