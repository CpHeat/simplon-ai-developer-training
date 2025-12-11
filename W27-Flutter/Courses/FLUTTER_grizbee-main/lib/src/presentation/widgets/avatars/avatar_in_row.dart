import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvatarInRow extends StatelessWidget {
  final String picture;
  final double imageRadius = 30;
  final backColor = Colors.grey;

  AvatarInRow({required this.picture});

  @override
  Widget build(BuildContext context) {
    return (picture.isEmpty)
        ? CircleAvatar(
            radius: imageRadius + 1,
            child: Icon(
              CupertinoIcons.cart_fill,
              color: Colors.white,
            ),
            backgroundColor: backColor,
          )
        : Container(
            child: CircleAvatar(
              radius: imageRadius,
              backgroundImage: AssetImage(('assets/graphics/avatars/$picture.png')),
            ),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: backColor)),
          );
  }
}

void getTest() {
  //int? x = null;
}
