import 'package:flutter/material.dart';
import '../widgets/square.widget.dart';

class SquaresScreen extends StatelessWidget {
  const SquaresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Squares'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SquareWidget(name: 'Red Square', color: Colors.red, size: 100),
            SizedBox(height: 20),
            SquareWidget(name: 'Green Square', color: Colors.green, size: 150),
            SizedBox(height: 20),
            SquareWidget(name: 'Blue Square', color: Colors.blue, size: 200),
          ],
        ),
      ),
    );
  }
}
