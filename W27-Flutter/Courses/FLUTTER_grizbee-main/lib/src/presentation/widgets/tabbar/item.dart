import 'package:flutter/cupertino.dart';

// This enumeration defines the sections of the tab bar
enum Item { info, scanner, transfer, more }

// This extension adds label and icon properties to the Item enumeration
extension ItemExtension on Item {
  // ignore: missing_return
  IconData get icon {
    switch (this) {
      case Item.info:
        return CupertinoIcons.news;
      case Item.scanner:
        return CupertinoIcons.qrcode_viewfinder;
      case Item.transfer:
        return CupertinoIcons.arrow_up_arrow_down;
      case Item.more:
        return CupertinoIcons.ellipsis;
    }
  }
}
