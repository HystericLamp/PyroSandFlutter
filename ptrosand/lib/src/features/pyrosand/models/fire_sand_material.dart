import 'material_type.dart';
import 'sand_material.dart';

class FireSandMaterial extends SandMaterial {
  final bool burningWood;

  const FireSandMaterial({
    required int lifespan, 
    this.burningWood = false,
    bool justSpawned = true,
  }) : super(
    type: MaterialType.fire,
    expires: true,
    lifespan: lifespan,
    justSpawned: justSpawned,
  );

  @override
  SandMaterial tick() {
    if (!expires || lifespan <= 1) {
      return SandMaterial(type: MaterialType.empty);
    }

    return FireSandMaterial(
      lifespan: lifespan-1,
      burningWood: burningWood,
      justSpawned: false
    );
  }

  @override
  FireSandMaterial clearSpawnFlag() {
    return FireSandMaterial(
      lifespan: lifespan,
      burningWood: burningWood,
      justSpawned: false,
    );
  }

  @override
  FireSandMaterial copyWith({
    MaterialType? type,
    int? lifespan,
    bool? expires,
    bool? justSpawned,
  }) {
    return FireSandMaterial(
      lifespan: lifespan ?? this.lifespan,
      burningWood: burningWood,
      justSpawned: justSpawned ?? this.justSpawned,
    );
  }

  factory FireSandMaterial.fire({
    int lifespan = 5,
    bool burningWood = false
  }) {
    return FireSandMaterial(
      lifespan: lifespan
    );
  }
}