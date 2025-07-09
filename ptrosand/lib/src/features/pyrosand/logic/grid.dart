import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';

class Grid {
  int width;
  int height;
  late List<List<SandMaterial>> _cells;

  Grid({required this.height, required this.width}) {
    _cells = List.generate(
      height,
      (y) => List.generate(
        width, 
        (x) => SandMaterial.empty()
      )
    );
  }

  bool isWithinBounds(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height;
  }

  ///
  /// Checks if a cell is occupied or empty
  ///
  bool canMoveTo(int x, int y) {
    return isWithinBounds(x, y) && getCell(x, y).isEmpty;
  }

  ///
  /// Moves material cell to (x, y) coordinates
  /// 
  void moveCell(int fromX, int fromY, int toX, int toY) {
    final movedCell = _cells[fromY][fromX];
    final updatedCell = movedCell.clearSpawnFlag();

    _cells[toY][toX] = updatedCell;
    _cells[fromY][fromX] = SandMaterial.empty();
  }

  void setCell(int x, int y, SandMaterial cell) {
    if (x >= 0 && x < width && y >= 0 && y < height) {
      _cells[y][x] = cell;
    }
  }

  SandMaterial getCell(int x, int y) {
    if (x >= 0 && x < width && y >= 0 && y < height) {
      return _cells[y][x];
    }

    if ((x < 0 || x >= width) && (y < 0 || y >= height)) {
      throw Exception('Requested coordinates (x, y) is not within bounds of the grid');
    } else if (x < 0 || x >= width) {
      throw Exception('X index is not within bounds of the grid');
    } else if (y < 0 || y >= height) {
      throw Exception('Y index is not within bounds of the grid');
    }

    return SandMaterial.empty();
  }

  bool isGridEmpty() {
    for (var row in _cells) {
      for (var cell in row) {
        if(cell.type != MaterialType.empty) {
          return false;
        }
      }
    }

    return true;
  }

  /// 
  /// For use in test debugging
  /// 
  String gridToString() {
    final buffer = StringBuffer();
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final cell = _cells[y][x];
        switch (cell.type) {
          case MaterialType.sand:
            buffer.write('S');
            break;
          case MaterialType.water:
            buffer.write('W');
            break;
          case MaterialType.fire:
            buffer.write('F');
            break;
          case MaterialType.wood:
            buffer.write('O');
            break;
          case MaterialType.charredWood:
            buffer.write('D');
            break;
          case MaterialType.steam:
            buffer.write('E');
            break;
          case MaterialType.empty:
            buffer.write('.');
            break;
        }
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}