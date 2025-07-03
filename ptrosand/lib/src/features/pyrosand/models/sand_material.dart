import 'package:flutter/material.dart' hide MaterialType;
import 'material_type.dart';

class SandMaterial {
  final MaterialType type;
  final int lifespan;
  final bool expires;

  const SandMaterial._({
    required this.type,
    this.lifespan = 0,
    this.expires = false,
  });

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
    );
  }

  bool get isEmpty => type == MaterialType.empty;

  SandMaterial decrementLifespan() {
    if (!expires || lifespan <= 0) return this;
    if (lifespan == 1) return SandMaterial.empty();
    return SandMaterial._(
      type: type,
      lifespan: lifespan - 1,
      expires: true,
    );
  }

  // From MaterialType extension
  Color get color => type.color;
  String get label => type.label;
  IconData get icon => type.icon;
}