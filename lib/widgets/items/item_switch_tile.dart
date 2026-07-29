import 'package:flutter/material.dart';

class ItemSwitchTile extends StatelessWidget {
  final bool _isChecked;
  final String _label, _subtitle;
  final void Function(bool isChecked, String type) _actionTapSwitch;
  const ItemSwitchTile({
    super.key,
    required this._isChecked,
    required this._label,
    required this._subtitle,
    required this._actionTapSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _isChecked,
      onChanged: (isChecked) => _actionTapSwitch.call(isChecked, _label),
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
