import 'package:flutter/material.dart';

class ItemDrawer extends StatelessWidget {
  final IconData icon;
  final String title;

  const ItemDrawer({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
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
