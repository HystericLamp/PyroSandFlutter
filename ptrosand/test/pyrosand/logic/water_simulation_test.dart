import 'package:flutter_test/flutter_test.dart';
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

void main() {
  group('WaterSimulation', () {
    late SandSimulation sim;
    late Grid grid;

    setUp(() {
      grid = Grid(height: 5, width: 5);
      sim = SandSimulation(grid: grid);
    });

    test('Initial Grid is Empty', () {
      expect(grid.isGridEmpty(), true);
    });

    test('Water Falls Straight Down', () {
      grid.setCell(2, 2, SandMaterial.water());
      sim.update();
      expect(grid.getCell(2, 3).type, MaterialType.water);
      expect(grid.getCell(2, 2).type, MaterialType.empty);
    });

    test('Sand Rests on Other Sand', () {
      // Water block we want to test (above)
      grid.setCell(2, 3, SandMaterial.water());

      // Water below it (bottom)
      grid.setCell(2, 4, SandMaterial.water());
      
      // Block diagonal movement
      grid.setCell(1, 4, SandMaterial.water());
      grid.setCell(3, 4, SandMaterial.water());

      sim.update();

      // Should not move cuz there is sand below it
      expect(grid.getCell(2, 3).type, MaterialType.water);
    });

    test('Sand slides diagonally', () {
      // Water block we want to test (above)
      grid.setCell(2, 3, SandMaterial.water());

      // Sand below it (bottom)
      grid.setCell(2, 4, SandMaterial.water());

      sim.update();

      // Should move diagonally
      expect(grid.getCell(2, 3).type, MaterialType.empty);
      expect(grid.getCell(1, 4).type, MaterialType.water);
    });
  });
}