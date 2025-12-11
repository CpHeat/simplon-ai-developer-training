import 'package:flutter/material.dart';

class HelloWidget extends StatelessWidget {
  final String name;
  const HelloWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Hello, $name !',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
