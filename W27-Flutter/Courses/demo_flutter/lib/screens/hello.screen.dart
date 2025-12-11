import 'package:flutter/material.dart';
import '../widgets/hello.widget.dart';

class HelloScreen extends StatelessWidget {
  const HelloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            HelloWidget(name: 'Foo Bar'),
          ],
        ),
      ),
    );
  }
}
