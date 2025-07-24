import 'package:flutter_test/flutter_test.dart';
import 'package:ptrosand/src/features/pyrosand/logic/fire_behavior.dart';
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/fire_sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/flammable_sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

void main() {
  group('Fire simulation tests', () {
    test('Fire floats up gradually and expires', () {
      final grid = Grid(width: 5, height: 10);
      final sim = SandSimulation(grid: grid);
      const x = 2;
      const y = 8;

      // Step 1: Place fire at (2, 8)
      grid.setCell(x, y, FireSandMaterial.fire(lifespan: 5));

      // Step 2: First tick — should NOT move yet (due to justSpawned)
      sim.update();

      expect(grid.getCell(x, y).type, MaterialType.fire);
      expect(grid.getCell(x-1, y).type, MaterialType.empty);
      expect(grid.getCell(x, y-1).type, MaterialType.empty);

      // Step 3: Second tick — should float up one cell to (2, 7)
      sim.update();
      
      expect(grid.getCell(x, y).type, MaterialType.empty);
      expect(grid.getCell(x, y-1).type, MaterialType.fire);

      // Step 4: Third tick — should move to (2, 6)
      sim.update();

      expect(grid.getCell(x, y-1).type, MaterialType.empty);
      expect(grid.getCell(x, y-2).type, MaterialType.fire);

      // Step 5: Fourth tick — should move to (2, 5)
      sim.update();

      expect(grid.getCell(x, y-2).type, MaterialType.empty);
      expect(grid.getCell(x, y-3).type, MaterialType.fire);

      // Step 6: Fifth tick — lifespan exhausted, fire disappears
      sim.update();

      expect(grid.getCell(x, y-3).type, MaterialType.empty);
    });

    test('Wood gradually burns when adjacent to fire', () {
      final grid = Grid(width: 5, height: 5);

      grid.setCell(2, 2, FlammableSandMaterial(type: MaterialType.wood));
      grid.setCell(1, 2, FireSandMaterial(lifespan: 8));

      Set<String> updatedCells = {};

      // Run fire react for a few ticks
      for (int i = 0; i < 6; i++) {
        FireBehavior.react(grid, 1, 2, updatedCells);
      }

      final cell = grid.getCell(2, 2);
      expect(cell is FireSandMaterial, true);
    });

    test('Fire burns water to steam', () {
      final grid = Grid(width: 5, height: 5);
      final sim = SandSimulation(grid: grid);

      grid.setCell(2, 1, SandMaterial.water());
      grid.setCell(2, 3, FireSandMaterial.fire(lifespan: 5));

      // Tick 1 — fire just spawned
      sim.update();
      expect(grid.getCell(2, 2).type, MaterialType.water, reason: 'Fire should not burn yet');

      // Tick 2 — fire evaporates water to steam
      sim.update();

      expect(grid.getCell(2, 2).type, MaterialType.empty, reason: 'Fire is extinguished');
      expect(grid.getCell(2, 3).type, MaterialType.steam, reason: 'Water should be turned to steam');

      // Tick 3 — steam still justSpawned, should stay
      sim.update();
      expect(grid.getCell(2, 3).type, MaterialType.steam);

      // Tick 4 — steam floats up
      sim.update();
      expect(grid.getCell(2, 2).type, MaterialType.steam);
    });
  });
}
