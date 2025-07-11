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
  MaterialType? _selectedMaterial;

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void _selectMaterial(MaterialType material) {
    setState(() {
      _selectedMaterial = material;
      _isOpen = false;
    });
    widget.onMaterialSelected(material);
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
                onPressed: () => _selectMaterial(material),
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
          tooltip: _isOpen
                  ? 'Close menu'
                  : (_selectedMaterial?.name ?? 'Open menu'),
          child: Icon(
            _isOpen 
              ? Icons.close 
              : (_selectedMaterial?.icon ?? Icons.menu),
          ),
        ),
      ],
    );
  }
}
