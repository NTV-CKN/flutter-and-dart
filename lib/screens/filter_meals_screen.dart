import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/providers/state_notifier/filter_meal_provider.dart';
import 'package:second_app/widgets/items/item_switch_tile.dart';

enum Filter { gluten, lactose, vegan, vegetarian }

class FilterMealsScreen extends ConsumerStatefulWidget {
  const FilterMealsScreen({super.key});

  @override
  ConsumerState<FilterMealsScreen> createState() {
    return _FilterMealsScreenState();
  }
}

class _FilterMealsScreenState extends ConsumerState<FilterMealsScreen> {
  final String glutenTitle = 'Gluten-free',
      lactoseTitle = 'Lactose-free',
      vegetarianTitle = 'Vegetarian',
      vegenTitle = 'Vegen';

  @override
  Widget build(BuildContext context) {
    final filterOptions = ref.watch(filterMealProvider);

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
            isChecked: filterOptions[Filter.gluten]!,
            label: glutenTitle,
            subtitle: 'Only include gluten-free meal',
            filter: Filter.gluten,
          ),
          ItemSwitchTile(
            isChecked: filterOptions[Filter.lactose]!,
            label: lactoseTitle,
            subtitle: 'Only include lactose-free meal',
            filter: Filter.lactose,
          ),
          ItemSwitchTile(
            isChecked: filterOptions[Filter.vegetarian]!,
            label: vegetarianTitle,
            subtitle: 'Only include vegetarian meal',
            filter: Filter.vegetarian,
          ),
          ItemSwitchTile(
            isChecked: filterOptions[Filter.vegan]!,
            label: vegenTitle,
            subtitle: 'Only include vegan meal',
            filter: Filter.vegan,
          ),
        ],
      ),
    );
  }
}
