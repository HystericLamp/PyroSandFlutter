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

  ///
  /// Function that updates the grid and runs the simulation
  /// 
  void update() {
    for (int y = (height - 1); y >= 0; y--) {
      for (int x = 0; x < width; x++) {
        final cell = grid[y][x];

        switch (cell.type) {
          case MaterialType.sand:
          case MaterialType.water:
            _updateMaterialFall(x, y);
            break;
          case MaterialType.fire:
            _updateFire(x, y);
            break;
          case MaterialType.empty:
            // Skip
            break;
        }
        // Other material updates
      }
    }
  }
  
  /// 
  /// Simulates and updates materials in a grid to fall. 
  /// Will also simulate a material to move to the side diagonally if something is below it.
  ///
  void _updateMaterialFall(int x, int y) {
    if (_canMoveTo(x, y+1)) {
      _moveCell(x, y, x, y+1);
    } else if (_canMoveTo(x-1, y+1)) {
      _moveCell(x, y, x-1, y+1);
    } else if (_canMoveTo(x+1, y+1)) {
      _moveCell(x, y, x+1, y+1);
    }
  }

  // For later if I want to add some different beavior for Sand and Water
  // _fallStraightThenDiagonal(x, y);
  // _fallStraightThenSpread(x, y);

  void _updateFire(int x, int y) {
    final cell = grid[y][x];

    if (_canMoveTo(x, y-1)) {
      _moveCell(x, y, x, y-1);
    } else if (_canMoveTo(x-1, y-1)) {
      _moveCell(x, y, x-1, y-1);
    } else if (_canMoveTo(x+1, y-1)) {
      _moveCell(x, y, x+1, y-1);
    } else {
      final updatedCell = cell.decrementLifespan();
      grid[y][x] = updatedCell;
    }
  }

  ///
  /// Checks if a cell is occupied or empty
  ///
  bool _canMoveTo(int x, int y) {
    return x >= 0 && x < width && y >= 0 && y < height && grid[y][x].isEmpty;
  }

  ///
  /// Moves material cell to (x, y) coordinates
  /// 
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
          case MaterialType.water:
            buffer.write('W');
            break;
          case MaterialType.fire:
            buffer.write('F');
            break;
          case MaterialType.empty:
            buffer.write('.');
            break;
          default:
            buffer.write('?');
        }
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}