import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

void main() {
  group('WaterSimulation', () {
    late SandSimulation sim;

    setUp(() {
      sim = SandSimulation(width: 5, height: 5);
    });

    test('Initial Grid is Empty', () {
      for (var row in sim.grid) {
        for (var cell in row) {
          expect(cell.type, MaterialType.empty);
        }
      }
    });

    test('Water Falls Straight Down', () {
      sim.setCell(2, 2, SandMaterial.water());
      sim.update();
      expect(sim.grid[3][2].type, MaterialType.water);
      expect(sim.grid[2][2].type, MaterialType.empty);
    });

    test('Sand Rests on Other Sand', () {
      // Water block we want to test (above)
      sim.setCell(2, 3, SandMaterial.water());

      // Water below it (bottom)
      sim.setCell(2, 4, SandMaterial.water());
      
      // Block diagonal movement
      sim.setCell(1, 4, SandMaterial.water());
      sim.setCell(3, 4, SandMaterial.water());

      sim.update();

      // Should not move cuz there is sand below it
      expect(sim.grid[3][2].type, MaterialType.water);
    });

    test('Sand slides diagonally', () {
      // Water block we want to test (above)
      sim.setCell(2, 3, SandMaterial.water());

      // Sand below it (bottom)
      sim.setCell(2, 4, SandMaterial.water());

      sim.update();

      // Should move diagonally
      expect(sim.grid[3][2].type, MaterialType.empty);
      expect(sim.grid[4][1].type, MaterialType.water);
    });
  });
}