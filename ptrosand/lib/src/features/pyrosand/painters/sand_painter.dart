import 'package:flutter/material.dart' hide MaterialType;
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

class SandPainter extends CustomPainter {
  final Grid grid;

  SandPainter(this.grid);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //calculate the width and height of each grid cell based on the total canvas size divided by the number of columns and rows.
    // Let's us scale the simulation to any screen size
    final cellWidth = size.width / grid.width;
    final cellHeight = size.height / grid.height;

    for (int y = 0; y < grid.height; y++) {
      for (int x = 0; x < grid.width; x++) {
        final cell = grid.getCell(x, y);
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