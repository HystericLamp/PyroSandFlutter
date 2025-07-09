import 'package:flutter/material.dart' hide MaterialType;
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

class FabMenu extends StatefulWidget {
  final Function(MaterialType) onMaterialSelected;

  const FabMenu({super.key, required this.onMaterialSelected});
  
  @override
  State<StatefulWidget> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> {
  bool _isOpen = false;

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen)
          ...fabMaterials.map((material) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FloatingActionButton(
                onPressed: () {
                  widget.onMaterialSelected(material);
                  _toggleMenu();
                },
                tooltip: material.name,
                mini: true,
                child: Icon(material.icon),
              ),
            );
          }),

        const SizedBox(height: 8),

        // Main FAB toggle
        FloatingActionButton(
          onPressed: _toggleMenu,
          child: Icon(_isOpen ? Icons.close : Icons.menu),
        ),
      ],
    );
  }
}
