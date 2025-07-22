import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/logic/material_updater.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

class SandSimulation {
  late final Grid _grid;
  late final MaterialUpdater _materialUpdater;

  SandSimulation({required Grid grid}) {
    _grid = grid;
    _materialUpdater = MaterialUpdater(_grid);
  }

  Grid getGrid() {
    return _grid;
  }

  ///
  /// Function that updates the grid and runs the simulation
  /// Each call of this method is 1 tick
  /// 
  void update() {
    final updatedCells = <String>{};

    for (int y = _grid.height-1; y >= 0; y--) {
      for (int x = 0; x < _grid.width; x++) {
        final key = '$x:$y';
        if (updatedCells.contains(key)) continue;

        final cell = _grid.getCell(x, y);

        switch (cell.type) {
          case MaterialType.sand:
          case MaterialType.water:
            _materialUpdater.updateMaterialFall(x, y);
            updatedCells.add(key);
            break;
          case MaterialType.fire:
            _materialUpdater.updateFire(x, y, updatedCells);
            break;
          case MaterialType.wood:
            // Stay in place
            break;
          case MaterialType.steam:
            _materialUpdater.updateFloat(x, y, updatedCells);
            break;
          case MaterialType.empty:
            // Skip
            break;
        }
        // Other material updates
      }
    }
  }
}