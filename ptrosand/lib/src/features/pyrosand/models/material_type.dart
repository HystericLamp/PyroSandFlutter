import 'package:flutter/material.dart';

enum MaterialType {
  empty,
  sand,
  water,
  fire,
  wood,
  charredWood,
  steam
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
      case MaterialType.wood:
        return Colors.brown;
      case MaterialType.charredWood:
        return Colors.orange;
      case MaterialType.steam:
        return Colors.grey[300]!;
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
      case MaterialType.wood:
        return Icons.crop_square;
      case MaterialType.charredWood:
        return Icons.crop_square_sharp;
      case MaterialType.steam:
        return Icons.cloud;
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
      case MaterialType.wood:
        return 'Wood';
      case MaterialType.charredWood:
        return 'Charred Wood';
      case MaterialType.steam:
        return 'Steam';
    }
  }
}

const List<MaterialType> fabMaterials = [
  MaterialType.sand,
  MaterialType.water,
  MaterialType.fire,
  MaterialType.wood
];