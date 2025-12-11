import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/widgets/avatars/avatar_container.dart';

// ignore: must_be_immutable
class ContactAvatar extends StatelessWidget {
  final String picture;
  double iconSize = 90;
  double avatarRadius = 60;

  ContactAvatar({required this.picture});

  ContactAvatar.payment({required this.picture, required this.iconSize, required this.avatarRadius});

  @override
  Widget build(BuildContext context) {
    if (picture.isEmpty) {
      return AvatarContainer(
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            CupertinoIcons.cart_fill,
            size: iconSize,
            color: Colors.grey,
          ),
          radius: avatarRadius,
        ),
      );
    }

    return AvatarContainer(
      avatar: CircleAvatar(
        backgroundImage: AssetImage('assets/graphics/avatars/$picture.png'),
        radius: avatarRadius,
      ),
    );
  }
}
