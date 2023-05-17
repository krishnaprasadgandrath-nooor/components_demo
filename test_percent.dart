import 'dart:developer';

void main(List<String> args) {
  int i = 81;
  while (i > 1) {
    log("before : $i");
    i ~/= 50;
    log("after: $i");
  }
}
