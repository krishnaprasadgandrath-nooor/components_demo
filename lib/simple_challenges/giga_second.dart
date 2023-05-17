import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'dart:developer';

void main(List<String> args) {
  DateFormat format = DateFormat('dd/MM/yyyy hh:mm:ss aa');
  String date = args.first;
  DateTime dateTime;
  try {
    dateTime = format.parse(date);
  } catch (e) {
    log("Parsing failed");
    dateTime = DateTime.now();
  }

  DateTime nextGig = dateTime.add(Duration(seconds: math.pow(10, 9).toInt()));
  log("${math.pow(10, 9)}" "\n");
  log("NExt Gig Second would be ${format.format(nextGig)}");
}
