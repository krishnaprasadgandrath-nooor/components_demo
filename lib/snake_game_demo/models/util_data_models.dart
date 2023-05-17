import 's_offset.dart';

enum SDirection { up, down, left, right }

const Map<SDirection, SDirection> oppositeDirections = {
  SDirection.up: SDirection.down,
  SDirection.down: SDirection.up,
  SDirection.left: SDirection.right,
  SDirection.right: SDirection.left,
};

extension DirectionUtil on SDirection {
  SOffset get nextOffset {
    switch (this) {
      case SDirection.up:
        return const SOffset(0, -1);
      case SDirection.down:
        return const SOffset(0, 1);
      case SDirection.left:
        return const SOffset(-1, 0);
      case SDirection.right:
        return const SOffset(1, 0);
    }
  }

  SOffset get prevOffset {
    switch (this) {
      case SDirection.up:
        return const SOffset(0, 1);
      case SDirection.down:
        return const SOffset(0, -1);
      case SDirection.left:
        return const SOffset(1, 0);
      case SDirection.right:
        return const SOffset(-1, 0);
    }
  }
}
