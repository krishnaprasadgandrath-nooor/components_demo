class StaticOne {
  StaticOne() {
    print("Object Created  ${this.hashCode}");
  }
}

void main(List<String> args) {
  StaticOne one = StaticOne();
  StaticOne two = StaticOne();
}
