import 'package:flutter/material.dart' hide MaterialType;
import 'package:ptrosand/src/features/pyrosand/logic/grid.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/fire_sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';
import 'package:ptrosand/src/features/pyrosand/painters/sand_painter.dart';
import 'package:ptrosand/src/features/pyrosand/widgets/fab_menu.dart';

class PyrosandView extends StatefulWidget {
  const PyrosandView({super.key});
  
  @override
  State<PyrosandView> createState() => _PyroSandViewState();
}

class _PyroSandViewState extends State<PyrosandView> with SingleTickerProviderStateMixin {
  late SandSimulation sim;
  late AnimationController _controller;
  MaterialType _selectedMaterial = MaterialType.sand;

  @override
  void initState() {
    super.initState();
    Grid grid = Grid(height: 100, width: 150);
    sim = SandSimulation(grid: grid);
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      setState(() {
        sim.update();
      });
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  SandMaterial _createMaterial(MaterialType type) {
    switch (type) {
      case MaterialType.sand:
        return SandMaterial.sand();
      case MaterialType.water:
        return SandMaterial.water();
      case MaterialType.fire:
        return FireSandMaterial.fire();
      case MaterialType.wood:
        return SandMaterial.wood();
      case MaterialType.steam:
        return SandMaterial.steam();
      case MaterialType.empty:
        return SandMaterial.empty();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              final box = context.findRenderObject() as RenderBox;
              final localPosition = box.globalToLocal(details.globalPosition);
              final dx = localPosition.dx ~/ (box.size.width / sim.getGrid().width);
              final dy = localPosition.dy ~/ (box.size.height / sim.getGrid().height);
              
              if (dx >= 0 && dx < sim.getGrid().width && dy >= 0 && dy < sim.getGrid().height) {
                final newMaterial = _createMaterial(_selectedMaterial);
                sim.getGrid().setCell(dx, dy, newMaterial);
              }
            },
            child: AnimatedBuilder(
              animation: _controller, 
              builder: (context, _) {
                return CustomPaint(
                  painter: SandPainter(sim.getGrid()),
                  size: Size.infinite,
                );
              }
            ),
          ),

          // FAB Menu
          Positioned(
            bottom: 16,
            right: 16,
            child: FabMenu(
              onMaterialSelected: (material) {
                setState(() {
                  _selectedMaterial = material;
                });
              }
            ),
          )
        ],
      )
      
    );
  }
}