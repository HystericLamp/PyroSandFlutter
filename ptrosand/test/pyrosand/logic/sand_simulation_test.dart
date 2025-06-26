import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';

void main() {
  group('SandSimulation', () {
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

    test('Sand Falls Straight Down', () {
      sim.setCell(2, 2, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));
      sim.update();
      expect(sim.grid[3][2].type, MaterialType.sand);
      expect(sim.grid[2][2].type, MaterialType.empty);
    });

    test('Sand Rests on Other Sand', () {
      // Sand block we want to test (above)
      sim.setCell(2, 3, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));

      // Sand below it (bottom)
      sim.setCell(2, 4, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));
      
      // Block diagonal movement
      sim.setCell(1, 4, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));
      sim.setCell(3, 4, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));

      sim.update();

      // Should not move cuz there is sand below it
      expect(sim.grid[3][2].type, MaterialType.sand);
    });

    test('Sand slides diagonally', () {
      // Sand block we want to test (above)
      sim.setCell(2, 3, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));

      // Sand below it (bottom)
      sim.setCell(2, 4, SandMaterial(MaterialType.sand, const Color(0xFFFFFF00)));

      sim.update();

      // Should move diagonally
      expect(sim.grid[3][2].type, MaterialType.empty);
      expect(sim.grid[4][1].type, MaterialType.sand);
    });
  });
}