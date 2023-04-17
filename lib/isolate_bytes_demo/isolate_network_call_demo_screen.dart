// import 'dart:isolate';

// import 'package:components_demo/utils/default_appbar.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:native_pdf_view/native_pdf_view.dart';

// void fetchBytes(List<dynamic> args) async {
//   SendPort sendPort = args.first;
//   String pdfUrl = args.last;
//   http.Response response = await http.get(Uri.parse(pdfUrl));
//   sendPort.send(response.bodyBytes);
// }

// class IsolateBytesDemoScreen extends StatefulWidget {
//   const IsolateBytesDemoScreen({super.key});

//   @override
//   State<IsolateBytesDemoScreen> createState() => _IsolateBytesDemoScreenState();
// }

// class _IsolateBytesDemoScreenState extends State<IsolateBytesDemoScreen> {
//   bool _isPdfLoaded = false;
//   Uint8List? pdfbytes;
//   Isolate? _isolate;

//   @override
//   void initState() {
//     _startFetching();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _isolate?.kill();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DefaultAppBar.appBar(context, "Isolate Bytes Demo"),
//       body: Center(
//           child: _isPdfLoaded
//               ? pdfbytes != null
//                   ? PdfView(controller: PdfController(document: PdfDocument.openData(pdfbytes!)))
//                   : const Text("Error Loading")
//               : const CircularProgressIndicator()),
//     );
//   }

//   Future<void> _startFetching() async {
//     ReceivePort listenPort = ReceivePort();
//     String pdfUrl = "https://www.africau.edu/images/default/sample.pdf";
//     _isolate = await Isolate.spawn(fetchBytes, [listenPort.sendPort, pdfUrl]);
//     listenPort.listen((message) {
//       pdfbytes = message as Uint8List;
//       _isPdfLoaded = true;
//       setState(() {});
//       listenPort.close();
//       _isolate?.kill();
//     });
//   }
// }
