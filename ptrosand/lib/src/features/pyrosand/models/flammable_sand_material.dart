import 'sand_material.dart';

class FlammableSandMaterial extends SandMaterial {
  final int burnTimer;

  const FlammableSandMaterial({
    required type,
    this.burnTimer = 6
  }) : super (
    type: type
  );
}