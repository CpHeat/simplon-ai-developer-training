import 'package:flutter/material.dart';

class SquareWidget extends StatelessWidget {
  final String name;
  final Color color;
  final double size;

  const SquareWidget({
    super.key,
    required this.name,
    required this.color,
    this.size = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: color,
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
