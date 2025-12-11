import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  final Widget content;

  BaseCard({required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: content,
        ),
      ),
    );
  }
}
