final start = 152085;
final end = 670283;
bool legal(i) {
  final s = i.toString();
  return twoAdjacent(s) && alwaysIncrease(s);
}

bool legalb(i) {
  final s = i.toString();
  return twoAdjacent(s) && alwaysIncrease(s) && exactlyTwo(s);
}

bool twoAdjacent(String s) {
  return Iterable.generate(s.length - 1)
      .any((i) => s.codeUnitAt(i) == s.codeUnitAt(i + 1));
}

bool exactlyTwo(String s) {
  return Iterable.generate(s.length - 1).any((i) =>
      s.codeUnitAt(i) == s.codeUnitAt(i + 1) &&
      (i == 0 || (s.codeUnitAt(i - 1) != s.codeUnitAt(i))) &&
      ((i == s.length - 2) || (s.codeUnitAt(i + 1) != s.codeUnitAt(i + 2))));
}

bool alwaysIncrease(String s) {
  return Iterable.generate(s.length - 1)
      .every((i) => s.codeUnitAt(i) <= s.codeUnitAt(i + 1));
}

int day4a() {
  return Iterable.generate(end - start + 1, (i) => i + start)
      .where(legal)
      .length;
}

int day4b() {
  return Iterable.generate(end - start + 1, (i) => i + start)
      .where(legalb)
      .length;
}
