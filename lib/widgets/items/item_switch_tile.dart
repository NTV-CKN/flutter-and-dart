import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/providers/state_notifier/filter_meal_provider.dart';
import 'package:second_app/screens/filter_meals_screen.dart';

class ItemSwitchTile extends ConsumerWidget {
  final bool _isChecked;
  final String _label, _subtitle;
  final Filter _filter;

  const ItemSwitchTile({
    super.key,
    required this._isChecked,
    required this._label,
    required this._subtitle,
    required this._filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchListTile(
      value: _isChecked,
      onChanged: (isChecked) {
        ref.read(filterMealProvider.notifier).switchFilter(_filter, isChecked);
      },
      subtitle: Text(
        _subtitle,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary.withAlpha(200),
        ),
      ),
      title: Text(
        _label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
