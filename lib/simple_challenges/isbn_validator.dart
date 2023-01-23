import 'dart:io';

void main(List<String> args) {
  String id = args.first;
  id = id.replaceAll('-', '');
  if (id.length != 10) {
    print("Not Valid");
    exit(-1);
  }
  List<String> chars = id.split('').toList();
  print("Numbers ${chars}");
  int sum = 0;
  for (var i = 0; i < chars.length; i++) {
    int? num;
    if (i == chars.length - 1 && chars[i] == 'X') {
      num = 10;
    } else {
      num = int.tryParse(chars[i]);
    }

    if (num == null) {
      print("Not Valid Numbers Mismatched ${chars[i]}");
      exit(-1);
    }

    sum += num * (10 - i);
  }
  print("Sum is $sum");
  if (sum % 11 == 0) {
    print("Valid");
  } else {
    print("Invalid");
  }
}
