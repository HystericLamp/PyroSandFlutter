import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to my App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'This app will help you get things done efficiently and effectively.',
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
                    MaterialPageRoute(builder: (context) => const NextView()),
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