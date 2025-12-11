import 'package:flutter/material.dart';
import 'red.screen.dart';
import 'green.screen.dart';
import 'blue.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Tes 3 écrans
  final List<Widget> _screens = const [
    RedScreen(),
    GreenScreen(),
    BlueScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // affiche la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Text('1', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            label: 'RED',
          ),
          BottomNavigationBarItem(
            icon: Text('2', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            label: 'GREEN',
          ),
          BottomNavigationBarItem(
            icon: Text('3', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            label: 'BLUE',
          ),
        ],
      ),
    );
  }
}
