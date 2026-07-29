import 'package:flutter/material.dart';
import 'package:second_app/widgets/items/item_switch_tile.dart';

class FilterMealsScreen extends StatefulWidget {
  const FilterMealsScreen({super.key});

  @override
  State<FilterMealsScreen> createState() {
    return _FilterMealsScreenState();
  }
}

class _FilterMealsScreenState extends State<FilterMealsScreen> {
  bool _isGlutenFree = false,
      _isLactoseFree = false,
      _isVegetarian = false,
      _isVegen = false;

  final String glutenTitle = 'Gluten-free',
      lactoseTitle = 'Lactose-free',
      vegetarianTitle = 'Vegetarian',
      vegenTitle = 'Vegen';

  void _actionSwitchTap(bool isChecked, String type) {
    setState(() {
      if (type == glutenTitle) {
        _isGlutenFree = isChecked;
      } else if (type == lactoseTitle) {
        _isLactoseFree = isChecked;
      } else if (type == vegetarianTitle) {
        _isVegetarian = isChecked;
      } else if (type == vegenTitle) {
        _isVegen = isChecked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filters',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: ListView(
        children: [
          ItemSwitchTile(
            isChecked: _isGlutenFree,
            label: glutenTitle,
            subtitle: 'Only include gluten-free meal',
            actionTapSwitch: _actionSwitchTap,
          ),
          ItemSwitchTile(
            isChecked: _isLactoseFree,
            label: lactoseTitle,
            subtitle: 'Only include lactose-free meal',
            actionTapSwitch: _actionSwitchTap,
          ),
          ItemSwitchTile(
            isChecked: _isVegetarian,
            label: vegetarianTitle,
            subtitle: 'Only include vegetarian meal',
            actionTapSwitch: _actionSwitchTap,
          ),
          ItemSwitchTile(
            isChecked: _isVegen,
            label: vegenTitle,
            subtitle: 'Only include vegan meal',
            actionTapSwitch: _actionSwitchTap,
          ),
        ],
      ),
    );
  }
}
