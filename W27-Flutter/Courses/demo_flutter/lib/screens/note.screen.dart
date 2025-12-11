import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  int note = 10;

  void incrementNote() {
    setState(() {
      note != 20 ? note++ : 20;
    });
  }

  void decrementNote() {
    setState(() {
      note != 0 ? note-- : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(note >= 10 ? 'assets/images/good.png' : 'assets/images/bad.png'),
            ),
            Text(
              "$note",
              style: TextStyle(fontSize: 100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: decrementNote,
                  child: const Text("MOINS"),
                ),
                ElevatedButton(
                  onPressed: incrementNote,
                  child: const Text("PLUS"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
