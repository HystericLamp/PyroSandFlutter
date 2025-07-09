import 'package:flutter/material.dart' hide MaterialType;
import 'material_type.dart';

class SandMaterial {
  final MaterialType type;
  final int lifespan;
  final bool expires;
  final bool justSpawned;

  const SandMaterial._({
    required this.type,
    this.lifespan = 0,
    this.expires = false,
    this.justSpawned = false
  });

  SandMaterial copyWith({
    MaterialType? type,
    int? lifespan,
    bool? expires,
    bool? justSpawned,
  }) {
    return SandMaterial._(
      type: type ?? this.type,
      lifespan: lifespan ?? this.lifespan,
      expires: expires ?? this.expires,
      justSpawned: justSpawned ?? this.justSpawned,
    );
  }

  SandMaterial tick() {
    if (!expires) return this;
    return lifespan <= 1
        ? SandMaterial.empty()
        : copyWith(lifespan: lifespan - 1);
  }

  factory SandMaterial.empty() {
    return const SandMaterial._(type: MaterialType.empty);
  }

  factory SandMaterial.sand() {
    return const SandMaterial._(
      type: MaterialType.sand,
      expires: false,
    );
  }

  factory SandMaterial.water() {
    return const SandMaterial._(
      type: MaterialType.water,
      expires: false,
    );
  }

  factory SandMaterial.fire({int lifespan = 5}) {
    return SandMaterial._(
      type: MaterialType.fire,
      lifespan: lifespan,
      expires: true,
      justSpawned: true
    );
  }

  factory SandMaterial.wood() {
    return const SandMaterial._(
      type: MaterialType.wood,
      expires: false
    );
  }

  factory SandMaterial.charredWood() {
    return const SandMaterial._(
      type: MaterialType.wood,
      expires: false
    );
  }

  factory SandMaterial.steam({int lifespan = 5}) {
    return SandMaterial._(
      type: MaterialType.steam,
      lifespan: lifespan,
      expires: true,
      justSpawned: true
    );
  }

  bool get isEmpty => type == MaterialType.empty;

  SandMaterial decrementLifespan() {
    if (!expires || lifespan <= 0) return this;
    if (lifespan == 1) return SandMaterial.empty();
    return copyWith(lifespan: lifespan - 1);
  }


  SandMaterial clearSpawnFlag() {
    if (!justSpawned) return this;
    return copyWith(justSpawned: false);
  }


  // From MaterialType extension
  Color get color => type.color;
  String get label => type.label;
  IconData get icon => type.icon;
}