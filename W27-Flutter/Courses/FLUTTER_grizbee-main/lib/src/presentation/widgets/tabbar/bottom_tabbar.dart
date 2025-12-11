import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/widgets/tabbar/item.dart';

// This widget is the tab bar of the app. It aims to :
// - builds all the active and inactive tab bar items.
// - reacts to item selection by changing the display of the item status (active/inactive)
class BottomTabBar extends StatelessWidget {
  final Item currentItem; // Current selected tab bar item
  final ValueChanged<Item> onSelectTab; // Callback for notifying a selection of a tab bar item

  BottomTabBar({required this.currentItem, required this.onSelectTab});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildTabBarItem(context: context, item: Item.info, itemLabel: Translation.of(context).info), // Item for "info" page
        _buildTabBarItem(context: context, item: Item.scanner, itemLabel: Translation.of(context).scanner), // Item for "scanner" page
        _buildTabBarItem(context: context, item: Item.transfer, itemLabel: Translation.of(context).transfer), // Item for "transfer" page
        _buildTabBarItem(context: context, item: Item.more, itemLabel: Translation.of(context).more), // Item for "more" page
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentItem.index,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      selectedFontSize: 12,
      onTap: (index) => onSelectTab(
        Item.values[index], // Notify that a tab bar item has been selected
      ),
    );
  }

  // This function builds tab bar item according to the section and a given color
  BottomNavigationBarItem _buildTabBarItem({required BuildContext context, required Item item, required String itemLabel}) {
    return BottomNavigationBarItem(
      label: itemLabel,
      // Appearance of standard items
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1.5),
        ),
        child: CircleAvatar(
          radius: 20.5,
          child: Icon(
            item.icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          backgroundColor: Colors.white,
        ),
      ),
      // Appearance of the selected item
      activeIcon: CircleAvatar(
        radius: 22,
        child: Icon(
          item.icon,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
