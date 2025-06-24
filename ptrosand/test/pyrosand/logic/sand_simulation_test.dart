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
  });
}