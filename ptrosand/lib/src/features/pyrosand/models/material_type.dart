import 'package:flutter/material.dart';

enum MaterialType {
  empty,
  sand,
  water,
  fire
}

extension MaterialTypeProperties on MaterialType {
  Color get color {
    switch (this) {
      case MaterialType.empty:
        return Colors.transparent;
      case MaterialType.sand:
        return Colors.yellow[700]!;
      case MaterialType.water:
        return Colors.lightBlue;
      case MaterialType.fire:
        return Colors.deepOrange;
    }
  }

  IconData get icon {
    switch (this) {
      case MaterialType.empty:
        return Icons.block;
      case MaterialType.sand:
        return Icons.grain;
      case MaterialType.water:
        return Icons.water;
      case MaterialType.fire:
        return Icons.fireplace;
    }
  }

  String get label {
    switch (this) {
      case MaterialType.empty:
        return 'Empty';
      case MaterialType.sand:
        return 'Sand';
      case MaterialType.water:
        return 'Water';
      case MaterialType.fire:
        return 'Fire';
    }
  }
}