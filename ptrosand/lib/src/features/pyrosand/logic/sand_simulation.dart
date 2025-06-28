import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

class SandSimulation {
  final int width;
  final int height;
  late List<List<SandMaterial>> grid;

  SandSimulation({required this.width, required this.height}) {
    grid = List.generate(
      height,
      (y) => List.generate(
        width, 
        (x) => SandMaterial.empty()
      )
    );
  }

  void update() {
    for (int y = (height - 1); y >= 0; y--) {
      for (int x = 0; x < width; x++) {
        final cell = grid[y][x];
        if (cell.type == MaterialType.sand) {
          _updateSand(x, y);
        }
        // Other material updates
      }
    }
  }

  void _updateSand(int x, int y) {
    if (_canMoveTo(x, y + 1)) {
      _moveCell(x, y, x, y + 1);
    } else if (_canMoveTo(x - 1, y + 1)) {
      _moveCell(x, y, x - 1, y + 1);
    } else if (_canMoveTo(x + 1, y + 1)) {
      _moveCell(x, y, x + 1, y + 1);
    }
  }

  bool _canMoveTo(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height && grid[y][x].isEmpty;
  }

  void _moveCell(int fromX, int fromY, int toX, int toY) {
    grid[toY][toX] = grid[fromY][fromX];
    grid[fromY][fromX] = SandMaterial.empty();
  }

  void setCell(int x, int y, SandMaterial cell) {
    if (x >= 0 && x < width && y >= 0 && y < height) {
      grid[y][x] = cell;
    }
  }

  /// For use in test debugging
  String gridToString() {
    final buffer = StringBuffer();
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final cell = grid[y][x];
        switch (cell.type) {
          case MaterialType.sand:
            buffer.write('S');
            break;
          case MaterialType.empty:
            buffer.write('.');
            break;
          default:
            buffer.write('?'); // In case you add other materials later
        }
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}