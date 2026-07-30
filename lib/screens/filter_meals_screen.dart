import 'package:flutter/material.dart';
import 'package:second_app/widgets/items/item_switch_tile.dart';

enum Filter { gluten, lactose, vegan, vegetarian }

class FilterMealsScreen extends StatefulWidget {
  final filterOptions;

  const FilterMealsScreen({super.key, required this.filterOptions});

  @override
  State<FilterMealsScreen> createState() {
    return _FilterMealsScreenState();
  }
}

class _FilterMealsScreenState extends State<FilterMealsScreen> {
  // bool _isGlutenFree = false,
  //     _isLactoseFree = false,
  //     _isVegetarian = false,
  //     _isVegen = false;

  final String glutenTitle = 'Gluten-free',
      lactoseTitle = 'Lactose-free',
      vegetarianTitle = 'Vegetarian',
      vegenTitle = 'Vegen';

  void _actionSwitchTap(bool isChecked, String type) {
    setState(() {
      if (type == glutenTitle) {
        widget.filterOptions[Filter.gluten] = isChecked;
        //_isGlutenFree = isChecked;
      } else if (type == lactoseTitle) {
        widget.filterOptions[Filter.lactose] = isChecked;
        //_isLactoseFree = isChecked;
      } else if (type == vegetarianTitle) {
        widget.filterOptions[Filter.vegetarian] = isChecked;
        //_isVegetarian = isChecked;
      } else if (type == vegenTitle) {
        widget.filterOptions[Filter.vegan] = isChecked;
        //_isVegen = isChecked;
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
            isChecked: widget.filterOptions[Filter.gluten],
            label: glutenTitle,
            subtitle: 'Only include gluten-free meal',
            actionTapSwitch: _actionSwitchTap,
          ),
          ItemSwitchTile(
            isChecked: widget.filterOptions[Filter.lactose],
            label: lactoseTitle,
            subtitle: 'Only include lactose-free meal',
            actionTapSwitch: _actionSwitchTap,
          ),
          ItemSwitchTile(
            isChecked: widget.filterOptions[Filter.vegetarian],
            label: vegetarianTitle,
            subtitle: 'Only include vegetarian meal',
            actionTapSwitch: _actionSwitchTap,
          ),
          ItemSwitchTile(
            isChecked: widget.filterOptions[Filter.vegan],
            label: vegenTitle,
            subtitle: 'Only include vegan meal',
            actionTapSwitch: _actionSwitchTap,
          ),
        ],
      ),
    );
  }
}
