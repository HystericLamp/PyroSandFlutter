import 'package:flutter/material.dart' hide MaterialType;
import '../models/sand_material.dart';

class SandPainter extends CustomPainter {
  final List<List<SandMaterial>> grid;

  SandPainter(this.grid) {
    assert(grid.isNotEmpty && grid.every((row) => row.length == grid[0].length), "Inconsistent grid rows");
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //calculate the width and height of each grid cell based on the total canvas size divided by the number of columns and rows.
    // Let's us scale the simulation to any screen size
    final cellWidth = size.width / grid[0].length;
    final cellHeight = size.height / grid.length;

    for (int y = 0; y < grid.length; y++) {
      for (int x = 0; x < grid[x].length; x++) {
        final cell = grid[y][x];
        if (cell.type != MaterialType.empty) {
          paint.color = cell.color;
          canvas.drawRect(
            Rect.fromLTWH(
              x * cellWidth, 
              y * cellHeight, 
              cellWidth, 
              cellHeight
            ), 
            paint
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
  
}