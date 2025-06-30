import 'package:flutter/material.dart' hide MaterialType;
import 'package:ptrosand/src/features/pyrosand/models/material_type.dart';

class FabMenu extends StatefulWidget {
  final MaterialType selectedMaterial;
  final Function(MaterialType) onMaterialSelected;

  const FabMenu({
    Key? key,
    required this.selectedMaterial,
    required this.onMaterialSelected
  }) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isExpanded)
          ...MaterialType.values.map((type) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: FloatingActionButton(
              mini: true,
              heroTag: 'fab_$type',
              backgroundColor: type.color,
              onPressed: () {
                widget.onMaterialSelected(type);
                setState(() {
                  isExpanded = false;
                });
              },
              child: Icon(type.icon, color: Colors.white),
            ),
          )),

        FloatingActionButton(
          heroTag: 'main_fab',
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Icon(isExpanded ? Icons.close : Icons.palette),
        ),
      ],
    );
  }
}
