class SOffset {
  const SOffset(this.x, this.y);
  final double x;
  final double y;

  static const SOffset zero = SOffset(0, 0);

  operator +(SOffset other) {
    // print('$this + $other = (${x + other.x},${y + other.y})');
    return SOffset(x + other.x, y + other.y);
  }

  operator *(num value) {
    // print(' $this * $value = (${x * value},${y * value})');
    return SOffset(x * value, y * value);
  }

  @override
  String toString() => '($x,$y)';

  SOffset clone() => SOffset(x, y);
}
