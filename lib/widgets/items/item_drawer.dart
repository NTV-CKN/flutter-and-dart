import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function(String typeItem) actionTapDrawerItem;

  const ItemDrawer({
    super.key,
    required this.icon,
    required this.title,
    required this.actionTapDrawerItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        actionTapDrawerItem.call(title);
      },
      leading: Icon(
        icon,
        size: 23,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
