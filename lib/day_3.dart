import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:quiver/iterables.dart';
import 'package:vector_math/vector_math.dart';

class Move {
  final String direction;
  final int count;

  Move(this.direction, this.count);
}

List<List<Move>> day3Input() {
  return File('data/day3.txt')
      .readAsLinesSync()
      .map((line) => line
          .split(',')
          .map((move) => Move(move[0], int.parse(move.substring(1))))
          .toList(growable: false))
      .toList(growable: false);
}

final moves = {
  'R': Vector2(1, 0),
  'L': Vector2(-1, 0),
  'U': Vector2(0, 1),
  'D': Vector2(0, -1),
};

day3a() {
  final wires = day3Input();
  final sets = wires.map((wire) {
    final aSet = Set<Vector2>();
    var pos = Vector2(0, 0);
    wire.forEach((move) {
      final dir = moves[move.direction];
      Iterable.generate(move.count).forEach((i) {
        pos += dir;
        aSet.add(pos);
      });
    });
    return aSet;
  }).toList();
  return min(
      sets.first.intersection(sets.last).map((a) => a[0].abs() + a[1].abs()));
}

day3b() {
  final wires = day3Input();
  final sets = wires.map((wire) {
    final aSet = Map<Vector2, int>();
    var pos = Vector2(0, 0);
    int step = 0;
    wire.forEach((move) {
      final dir = moves[move.direction];
      Iterable.generate(move.count).forEach((i) {
        pos += dir;
        step += 1;
        aSet.putIfAbsent(pos, () => step);
      });
    });
    return aSet;
  }).toList();
  return min(sets.first.keys
      .toSet()
      .intersection(sets.last.keys.toSet())
      .toList(growable: false)
      .map<int>((pos) => sets.fold<int>(0, (a, b) => a + b[pos])));
}
