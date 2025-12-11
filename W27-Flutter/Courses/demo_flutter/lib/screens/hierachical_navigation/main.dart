import 'package:flutter/material.dart';
import 'home.screen.dart';
import 'red.screen.dart';
import 'green.screen.dart';
import 'blue.screen.dart';
import 'green_light.screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/red': (context) => RedScreen(),
        '/green': (context) => GreenScreen(),
        '/green_light': (context) => GreenLightScreen(),
        '/blue': (context) => BlueScreen()
      },
    );
  }
}
