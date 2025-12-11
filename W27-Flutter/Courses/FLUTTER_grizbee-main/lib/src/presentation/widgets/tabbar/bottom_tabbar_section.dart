import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/item.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/bottom_tabbar_section_navigator.dart';

// This widget aims to build a specific navigator for each section of the tab bar
class BottomTabBarSection extends StatelessWidget {
  final Item item;
  final Item currentItem;

  BottomTabBarSection({required this.item, required this.currentItem});

  @override
  Widget build(BuildContext context) {
    return Offstage(
      // Make section visible if selected
      offstage: currentItem != item,
      // Specific navigator by section
      child: BottomTabBarSectionNavigator(
        navigatorKey: navigatorKeys[item]!,
        item: item,
      ),
    );
  }
}
