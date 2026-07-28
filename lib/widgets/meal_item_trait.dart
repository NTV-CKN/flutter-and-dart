import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  final IconData iconData;
  final String label;

  const MealItemTrait({super.key, required this.iconData, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.onPrimary.withAlpha(240),
          size: 17,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 17,
            color: Theme.of(context).colorScheme.onPrimary.withAlpha(240),
          ),
        ),
      ],
    );
  }
}
