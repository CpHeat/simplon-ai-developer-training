import 'package:flutter/material.dart';

class GreenLightScreen extends StatelessWidget {
  const GreenLightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Green Light Screen')),
      backgroundColor: const Color.fromARGB(255, 199, 237, 200),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
