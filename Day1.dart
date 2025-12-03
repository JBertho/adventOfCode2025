import 'dart:io';

enum Direction { left, right }

final class Rotation {
  final Direction direction;
  final int clicks;

  Rotation(this.direction, this.clicks);

  factory Rotation.fromString(final String input) {
    final direction = input[0] == 'L' ? Direction.left : Direction.right;
    final clicks = int.parse(input.substring(1));
    return Rotation(direction, clicks);
  }

  int get value => switch (direction) {
    Direction.left => 0 - clicks,
    Direction.right => 0 + clicks,
  };

  @override
  String toString() => '$direction$clicks';
}

Future<List<Rotation>> loadData(File file) async {
  final lines = await file.readAsLines();

  return lines.map(Rotation.fromString).toList();
}


Future<int> calculate(File file) async {
  final contents = await loadData(file);

  int position = 50;
  int numTimesAtZero = 0;

  for (final rotation in contents) {

    final wasAtZero = position == 0;

    position += rotation.value;

    if (position >= 100) {
      numTimesAtZero += (position ~/ 100).abs();
    } else if (position < 0) {
      numTimesAtZero += (position ~/ 100).abs();

      if (!wasAtZero) {
        numTimesAtZero++;
      }
    } else if (position == 0) {
      numTimesAtZero++;
    }

    position = position % 100;
  }

  return numTimesAtZero;
}