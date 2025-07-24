import 'package:ptrosand/src/features/pyrosand/models/flammable_sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/models/fire_sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';

class FireBehavior {

  ///
  /// Logic on Fire interaction with other materials
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
        if (neighbor is FlammableSandMaterial) {
          _materialBurn(grid, neighbor, nx, ny, updatedCells);
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

  static void _materialBurn(Grid grid, FlammableSandMaterial neighbor, int nx, int ny, Set<String> updatedCells) {
    int newBurnTimer = neighbor.burnTimer - 1;

    if (newBurnTimer <= 0) {
      // Fully burns and turns into fire
      grid.setCell(nx, ny, FireSandMaterial(lifespan: 8, burningWood: true));
    } else {
      // Update the flammable material with decreased burnTimer
      grid.setCell(nx, ny, FlammableSandMaterial(
        type: neighbor.type,
        burnTimer: newBurnTimer,
      ));

      // Optional visual: emit fire above
      if (grid.isWithinBounds(nx, ny - 1) &&
          grid.getCell(nx, ny - 1)?.type == MaterialType.empty) {
        grid.setCell(nx, ny - 1, FireSandMaterial(lifespan: 2));
      }
    }

    updatedCells.add('$nx:$ny');
  }
}