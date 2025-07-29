import 'package:flutter_test/flutter_test.dart';
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

void main() {
  group('SandSimulation', () {
    late SandSimulation sim;
    late Grid grid;

    setUp(() {
      grid = Grid(width: 5, height: 5);
      sim = SandSimulation(grid: grid);
    });

    test('Initial Grid is Empty', () {
      expect(grid.isGridEmpty(), true);
    });

    test('Sand Falls Straight Down', () {
      grid.setCell(2, 2, SandMaterial.sand());
      sim.update();
      expect(grid.getCell(2, 3).type, MaterialType.sand);
      expect(grid.getCell(2, 2).type, MaterialType.empty);
    });

    test('Sand Rests on Other Sand', () {
      // Sand block we want to test (above)
      grid.setCell(2, 3, SandMaterial.sand());

      // Sand below it (bottom)
      grid.setCell(2, 4, SandMaterial.sand());

      // Block diagonal movement
      grid.setCell(1, 4, SandMaterial.sand());
      grid.setCell(3, 4, SandMaterial.sand());

      sim.update();

      // Should not move cuz there is sand below it
      expect(grid.getCell(2, 3).type, MaterialType.sand);
    });

    test('Sand slides diagonally', () {
      grid.setCell(2, 3, SandMaterial.sand());

      grid.setCell(2, 4, SandMaterial.sand());

      sim.update();

      // Should move diagonally
      expect(grid.getCell(2, 3).type, MaterialType.empty);
      expect(grid.getCell(1, 4).type, MaterialType.sand);
    });

    test('Sand smothers water', () {
      grid.setCell(2, 3, SandMaterial.sand());

      grid.setCell(2, 4, SandMaterial.water());

      sim.update();

      // Water should be gone
      expect(grid.getCell(2, 3).type, MaterialType.empty);
      expect(grid.getCell(2, 4).type, MaterialType.sand);
    });
  });
}