import 'package:flutter/material.dart' hide MaterialType;
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

class MaterialUpdater {
  final Grid _grid;

  MaterialUpdater(this._grid);

  /// 
  /// Simulates and updates materials in a grid to fall. 
  /// Will also simulate a material to move to the side diagonally if something is below it.
  ///
  void updateMaterialFall(int x, int y) {
    if (_grid.canMoveTo(x, y+1)) {
      _grid.moveCell(x, y, x, y+1);
    } else if (_grid.canMoveTo(x-1, y+1)) {
      _grid.moveCell(x, y, x-1, y+1);
    } else if (_grid.canMoveTo(x+1, y+1)) {
      _grid.moveCell(x, y, x+1, y+1);
    }
  }

  // For later if I want to add some different beavior for Sand and Water
  // _fallStraightThenDiagonal(x, y);
  // _fallStraightThenSpread(x, y);

  ///
  /// Logic to how materials "float" up on the grid
  /// 
  void updateFloat(int x, int y, Set<String> updatedCells) {
    SandMaterial cell = _grid.getCell(x, y).tick();

    if (cell.justSpawned) {
      cell = cell.clearSpawnFlag();
      _grid.setCell(x, y, cell);
      updatedCells.add('$x:$y');
      return;
    }

    if (_grid.canMoveTo(x, y-1)) {
      _grid.setCell(x, y-1, cell);
      _grid.setCell(x, y, SandMaterial.empty());
      updatedCells.add('$x:${y-1}');
    } else if (_grid.canMoveTo(x-1, y-1)) {
      _grid.setCell(x-1, y-1, cell);
      _grid.setCell(x, y, SandMaterial.empty());
      updatedCells.add('${x-1}:${y-1}');
    } else if (_grid.canMoveTo(x+1, y-1)) {
      _grid.setCell(x+1, y-1, cell);
      _grid.setCell(x, y, SandMaterial.empty());
      updatedCells.add('${x + 1}:${y - 1}');
    } else {
      // Stay in place, but apply ticked version
      _grid.setCell(x, y, cell);
      updatedCells.add('$x:$y');
    }
  }

  void updateFire(int x, int y, Set<String> updatedCells) {
    SandMaterial cell = _grid.getCell(x, y);

    // Check if it was just spawned
    if (cell.justSpawned) {
      cell = cell.clearSpawnFlag();
      _grid.setCell(x, y, cell);
      updatedCells.add('$x:$y');
      return;
    }

    // Spread fire or react
    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;

        int nx = x + dx;
        int ny = y + dy;

        if (!_grid.isWithinBounds(nx, ny)) continue;

        final neighbor = _grid.getCell(nx, ny);

        // Wood burns into fire
        if (neighbor.type == MaterialType.wood) {
          _grid.setCell(nx, ny, SandMaterial.fire());
          updatedCells.add('$nx:$ny');
        }

        // Fire + Water = Steam
        if (neighbor.type == MaterialType.water) {
          _grid.setCell(nx, ny, SandMaterial.empty());
          _grid.setCell(x, y, SandMaterial.steam(lifespan: 5));
          updatedCells.add('$nx:$ny');
          updatedCells.add('$x:$y');
          return;
        }
      }
    }

    cell = _grid.getCell(x, y).tick();

    // Move fire upward if possible
    if (_grid.canMoveTo(x, y-1)) {
      _grid.setCell(x, y-1, cell);
      _grid.setCell(x, y, SandMaterial.empty());
      updatedCells.add('$x:${y-1}');
    } else if (_grid.canMoveTo(x-1, y-1)) {
      _grid.setCell(x-1, y-1, cell);
      _grid.setCell(x, y, SandMaterial.empty());
      updatedCells.add('${x-1}:${y-1}');
    } else if (_grid.canMoveTo(x+1, y-1)) {
      _grid.setCell(x+1, y-1, cell);
      _grid.setCell(x, y, SandMaterial.empty());
      updatedCells.add('${x + 1}:${y - 1}');
    } else {
      // Stay in place, but apply ticked version
      _grid.setCell(x, y, cell);
      updatedCells.add('$x:$y');
    }
  }
}