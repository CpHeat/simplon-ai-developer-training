import 'package:flutter/material.dart';

class BlueScreen extends StatelessWidget {
  const BlueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blue Screen')),
      backgroundColor: Colors.blue,
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
    );
  }
}
