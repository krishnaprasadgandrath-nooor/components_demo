void main(List<String> args) {
  int i = 81;
  while (i > 1) {
    print("before : $i");
    i ~/= 50;
    print("after: $i");
  }
}
