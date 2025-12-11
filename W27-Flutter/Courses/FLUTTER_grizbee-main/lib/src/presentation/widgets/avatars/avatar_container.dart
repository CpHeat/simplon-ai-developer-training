import 'package:flutter/material.dart';

class AvatarContainer extends StatelessWidget {
  final Widget avatar;

  AvatarContainer({required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 2)],
      ),
      child: avatar,
    );
  }
}