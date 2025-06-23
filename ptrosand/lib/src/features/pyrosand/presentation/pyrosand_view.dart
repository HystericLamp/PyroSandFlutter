import 'package:flutter/material.dart';

class PyrosandView extends StatelessWidget {
  const PyrosandView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'The main area',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
  
}