import 'dart:io';

day1() {
  int compute(x) {
    final next = x ~/ 3 - 2;
    return next <= 0 ? 0 : next + compute(next);
  }

  return File('./data/day1.txt')
      .readAsLinesSync()
      .map((x) => int.parse(x))
      .map(compute)
      .reduce((a, b) => a + b);
}
