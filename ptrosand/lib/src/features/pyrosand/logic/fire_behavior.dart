import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/models/fire_sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';

class FireBehavior {

  ///
  /// Logic on Fire spreading to other flammable materials
  /// 
  static bool react(Grid grid, int x, int y, Set<String> updatedCells) {
    bool fireExtinguished = false;

    for (int dx = -1; dx <= 1; dx++) {
      for (int dy = -1; dy <= 1; dy++) {
        if (dx == 0 && dy == 0) continue;

        int nx = x + dx;
        int ny = y + dy;

        if (!grid.isWithinBounds(nx, ny)) continue;

        final neighbor = grid.getCell(nx, ny);

        // Wood burns into fire
        if (neighbor.type == MaterialType.wood) {
          grid.setCell(nx, ny, FireSandMaterial(lifespan: 8, burningWood: true));
          updatedCells.add('$nx:$ny');
        }

        // Fire + Water = Steam
        if (neighbor.type == MaterialType.water) {
          grid.setCell(nx, ny, SandMaterial.empty());
          grid.setCell(x, y, SandMaterial.steam(lifespan: 8));
          updatedCells.add('$nx:$ny');
          updatedCells.add('$x:$y');
          fireExtinguished = true;
        }
      }
    }

    return fireExtinguished;
  }
}