import 'package:demo_flutter/screens/dark_light.screen.dart';
import 'package:demo_flutter/screens/note.screen.dart';
import 'package:demo_flutter/screens/profiles.screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ProfilesScreen()
    );
  }
}
