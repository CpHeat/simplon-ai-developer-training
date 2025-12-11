import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/red'),
              child: const Text('Go to Red Screen', style: TextStyle(fontSize: 20, color: Colors.red)),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/green'),
              child: const Text('Go to Green Screen', style: TextStyle(fontSize: 20, color: Colors.green)),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/blue'),
              child: const Text('Go to Blue Screen', style: TextStyle(fontSize: 20, color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
