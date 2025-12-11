import 'package:flutter/material.dart';

class DarkLightScreen extends StatefulWidget {
  const DarkLightScreen({super.key});

  @override
  State<DarkLightScreen> createState() => _DarkLightScreenState();
}

class _DarkLightScreenState extends State<DarkLightScreen> {
  bool isDarkMode = false;

  void toggleMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: toggleMode,
            child: Text(isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
          ),
        ),
      ),
    );
  }
}
