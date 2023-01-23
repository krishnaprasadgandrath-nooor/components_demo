void main(List<String> args) {
  String first = args.first;
  String second = args.last;
  int maxLength = first.length > second.length ? first.length : second.length;
  int minLength = first.length > second.length ? second.length : first.length;
  int count = 0;
  for (var i = 0; i < minLength; i++) {
    if (first[i] != second[i]) count++;
  }
  count += maxLength - minLength;
  print("Hamming Difference is : $count");
}
