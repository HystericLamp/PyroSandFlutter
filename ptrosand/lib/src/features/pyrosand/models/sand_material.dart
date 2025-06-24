import 'package:flutter/material.dart';

enum MaterialType {
  empty,
  sand,
  water,
  fire
}

class SandMaterial {
  MaterialType type;
  Color color;

  SandMaterial(this.type, this.color);

  factory SandMaterial.empty() {
    return SandMaterial(MaterialType.empty, Colors.black);
  }

  bool get isEmpty => type == MaterialType.empty;
}