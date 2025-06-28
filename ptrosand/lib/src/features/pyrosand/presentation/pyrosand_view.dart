import 'package:flutter/material.dart' hide MaterialType;
import 'package:flutter/scheduler.dart';
import 'package:ptrosand/src/features/pyrosand/logic/sand_simulation.dart';
import 'package:ptrosand/src/features/pyrosand/models/sand_material.dart';
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';
import 'package:ptrosand/src/features/pyrosand/painters/sand_painter.dart';

class PyrosandView extends StatefulWidget {
  const PyrosandView({super.key});
  
  @override
  State<PyrosandView> createState() => _PyroSandViewState();
}

class _PyroSandViewState extends State<PyrosandView> with SingleTickerProviderStateMixin {
  late SandSimulation sim;
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    sim = SandSimulation(width: 100, height: 150);
    _ticker = Ticker((_) {
      setState(() {
        sim.update();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          final box = context.findRenderObject() as RenderBox;
          final localPosition = box.globalToLocal(details.globalPosition);
          final dx = localPosition.dx ~/ (box.size.width / sim.width);
          final dy = localPosition.dy ~/ (box.size.height / sim.height);
          sim.setCell(dx, dy, SandMaterial(MaterialType.sand, Colors.yellow));
        },
        child: CustomPaint(
          painter: SandPainter(sim.grid),
          size: Size.infinite,
        ),
      )
    );
  }
}