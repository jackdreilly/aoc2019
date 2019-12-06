import 'dart:io';

enum Op { M, A, I, O, JT, JF, LT, EQ, HALT }

final lookup = {
  1: Op.A,
  2: Op.M,
  3: Op.I,
  4: Op.O,
  5: Op.JT,
  6: Op.JF,
  7: Op.LT,
  8: Op.EQ,
  99: Op.HALT,
};
day5a([int inputValue = 5]) {
  final ints = Map.from(File('./data/day5.txt')
      .readAsLinesSync()
      .expand((l) => l.split(',').map(int.parse))
      .toList(growable: false)
      .asMap());
  int pos = 0;
  while (pos < ints.length) {
    final opNum = ints[pos];
    final code = lookup[opNum % 100];
    var rem = opNum ~/ 100;
    final mode0 = rem % 10 == 0;
    rem = rem ~/ 10;
    final mode1 = rem % 10 == 0;
    final val0 = mode0 ? ints[ints[pos + 1]] : ints[pos + 1];
    final val1 = mode1 ? ints[ints[pos + 2]] : ints[pos + 2];
    final val2 = ints[pos + 3];
    print([opNum, code, rem, mode0, mode1, val0, val1, val2, pos]);
    switch (code) {
      case Op.A:
        ints[val2] = val0 + val1;
        pos += 4;
        break;
      case Op.M:
        ints[val2] = val0 * val1;
        pos += 4;
        break;
      case Op.I:
        ints[ints[pos + 1]] = inputValue;
        pos += 2;
        break;
      case Op.O:
        print(val0);
        pos += 2;
        break;
      case Op.JT:
        if (val0 != 0) {
          pos = val1;
          break;
        }
        pos += 3;
        break;
      case Op.JF:
        if (val0 == 0) {
          pos = val1;
          break;
        }
        pos += 3;
        break;
      case Op.LT:
        ints[val2] = (val0 < val1) ? 1 : 0;
        pos += 4;
        break;
      case Op.EQ:
        ints[val2] = (val0 == val1) ? 1 : 0;
        pos += 4;
        break;
      case Op.HALT:
        print("HALT");
        return;
      default:
        return;
    }
  }
}
