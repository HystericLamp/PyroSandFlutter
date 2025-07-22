import 'package:ptrosand/src/features/pyrosand/logic/fire_behavior.dart';
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';

class MaterialUpdater {
  Grid _grid;

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

    if (_ifJustSpawned(cell, x, y, updatedCells)) return;

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

  ///
  /// Logic to how Fire "float" up on the grid
  /// Also handles how Fire burns nearby flammable materials
  /// 
  void updateFire(int x, int y, Set<String> updatedCells) {
    SandMaterial cell = _grid.getCell(x, y);

    if (_ifJustSpawned(cell, x, y, updatedCells)) return;
    cell = _grid.getCell(x, y).tick();
    _grid.setCell(x, y, cell);

    if (!cell.justSpawned) {
      if(FireBehavior.react(_grid, x, y, updatedCells) == true) return;

      // Float upward
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

  ///
  /// Checks to see if material justSpawned. If it did return true, else false.
  /// 
  bool _ifJustSpawned(SandMaterial cell, int x, int y, Set<String> updatedCells) {
    if (cell.justSpawned) {
      cell = cell.clearSpawnFlag();
      _grid.setCell(x, y, cell);
      updatedCells.add('$x:$y');
      return true;
    }
    
    return false;
  }
}