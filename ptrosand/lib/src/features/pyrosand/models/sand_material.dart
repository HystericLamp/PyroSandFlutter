import 'package:flutter/material.dart' hide MaterialType;
import 'material_type.dart';

class SandMaterial {
  MaterialType type;
  Color color;

  SandMaterial(this.type, this.color);

  factory SandMaterial.empty() {
    return SandMaterial(MaterialType.empty, Colors.black);
  }

  bool get isEmpty => type == MaterialType.empty;
}