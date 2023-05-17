import 'dart:developer';

void main(List<String> args) {
  int num = int.tryParse(args.first) ?? 10;
  log("Num is : $num");
  int sum = 0;
  if (num == 1) sum += 1;
  for (var i = 1; i <= num / 2; i++) {
    if (num % i == 0) sum += i;
  }
  log("Sum is $sum");
}
