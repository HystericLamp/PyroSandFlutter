import 'package:flutter/material.dart';
import 'package:ptrosand/src/features/pyrosand/presentation/pyrosand_view.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to my PyroSand Imitation App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'This app is my attempt at re-building the PyroSand game, which was an old Game on the web that allows you to place \'sand\', watch it fall and interact with other \'sand\' material.'
                ' Although this is a minor imitation, I was inspired with Flutter and wanted to use its capabilities for this game. Please enjoy!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PyrosandView()),
                  );
                }, 
                child: const Text('Get Started')
              )
            ],
          ),
          ),
      ),
    );
  }
}