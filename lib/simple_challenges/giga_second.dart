import 'package:intl/intl.dart';
import 'dart:math';

void main(List<String> args) {
  DateFormat format = DateFormat('dd/MM/yyyy hh:mm:ss aa');
  String date = args.first;
  DateTime dateTime;
  try {
    dateTime = format.parse(date);
  } catch (e) {
    print("Parsing failed");
    dateTime = DateTime.now();
  }

  DateTime nextGig = dateTime.add(Duration(seconds: pow(10, 9).toInt()));
  print("${pow(10, 9)}" + "\n");
  print("NExt Gig Second would be ${format.format(nextGig)}");
}
