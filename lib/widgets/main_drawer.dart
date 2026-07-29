import 'package:flutter/material.dart';
import 'package:second_app/widgets/items/item_drawer.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String typeItem) actionTapDrawerItem;

  const MainDrawer({super.key, required this.actionTapDrawerItem});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(
                    context,
                  ).colorScheme.onPrimaryContainer.withAlpha(200),
                  Theme.of(context).colorScheme.onPrimaryContainer,
                ],
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Here we go!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ],
            ),
          ),
          ItemDrawer(
            icon: Icons.food_bank,
            title: 'Meals',
            actionTapDrawerItem: actionTapDrawerItem,
          ),
          ItemDrawer(
            icon: Icons.settings,
            title: 'Filters',
            actionTapDrawerItem: actionTapDrawerItem,
          ),
        ],
      ),
    );
  }
}
