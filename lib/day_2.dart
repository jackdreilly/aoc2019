import 'dart:io';

List<int> day2Input() {
  return File('data/day2.txt')
      .readAsStringSync()
      .split(',')
      .map(int.parse)
      .toList(growable: false);
}

day2(int noun, int verb) {
  final mem = day2Input();
  print([noun, verb]);
  mem[1] = noun;
  mem[2] = verb;
  int pos = 0;
  while (mem[pos] != 99) {
    final command = mem[pos];
    final op = command == 1 ? (a, b) => a + b : (a, b) => a * b;
    mem[mem[pos + 3]] = op(mem[mem[pos + 1]], mem[mem[pos + 2]]);
    pos += 4;
  }
  return mem[0];
}

day2a() {
  return day2(12, 2);
}

int day2b() {
  final ans =
      Iterable.generate(100, (i) => Iterable.generate(100, (j) => [i, j]))
          .expand((i) => i)
          .firstWhere((l) => day2(l[0], l[1]) == 19690720);
  return 100 * ans[0] + ans[1];
}
