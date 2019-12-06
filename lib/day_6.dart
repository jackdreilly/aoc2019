import 'dart:io';

day6a() {
  final map = Map<String, Set<String>>();
  List<MapEntry<String, int>> children(String key, [int depth = 0]) {
    final entry = map[key];
    if (entry == null) {
      return [];
    }
    return entry.expand((child) {
      final next = children(child, depth + 1);
      next.add(MapEntry(child, depth));
      return next;
    }).toList();
  }

  File('./data/day6.txt').readAsLinesSync().forEach((line) {
    final splits = line.split(')');
    final a = splits[0];
    final b = splits[1];
    map.putIfAbsent(a, () => {}).add(b);
  });
  final matches = Map.fromEntries(children('COM'))
    ..removeWhere((k, v) =>
        Map.fromEntries(children(k))
            .keys
            .toSet()
            .intersection({'YOU', 'SAN'}).length <
        2);
  final entries = matches.entries.toList();
  entries.sort((a, b) => b.value.compareTo(a.value));
  final previous = entries.first.key;
  print([entries, previous]);
  final _children = Map.fromEntries(children(previous));
  final depthYou = _children['YOU'];
  final depthSan = _children['SAN'];
  return depthYou + depthSan;
}
