import 'package:flutter_test/flutter_test.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

void main() {
  group('Fire simulation tests', () {
    test('Fire floats up gradually and expires', () {
      final sim = SandSimulation(width: 5, height: 10);
      const x = 2;
      const y = 8;

      // Step 1: Place fire at (2, 8)
      sim.setCell(x, y, SandMaterial.fire(lifespan: 5));

      // Step 2: First tick — should NOT move yet (due to justSpawned)
      sim.update();

      expect(sim.grid[y][x].type, MaterialType.fire);
      expect(sim.grid[y][x - 1].type, MaterialType.empty);
      expect(sim.grid[y - 1][x].type, MaterialType.empty);

      // Step 3: Second tick — should float up one cell to (2, 7)
      sim.update();
      
      expect(sim.grid[y][x].type, MaterialType.empty);
      expect(sim.grid[y - 1][x].type, MaterialType.fire);

      // Step 4: Third tick — should move to (2, 6)
      sim.update();

      expect(sim.grid[y - 1][x].type, MaterialType.empty);
      expect(sim.grid[y - 2][x].type, MaterialType.fire);

      // Step 5: Fourth tick — should move to (2, 5)
      sim.update();

      expect(sim.grid[y - 2][x].type, MaterialType.empty);
      expect(sim.grid[y - 3][x].type, MaterialType.fire);

      // Step 6: Fifth tick — lifespan exhausted, fire disappears
      sim.update();
      
      expect(sim.grid[y - 3][x].type, MaterialType.empty);
    });
  });
}
