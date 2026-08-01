import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/providers/provider/dummy_provider.dart';
import 'package:second_app/screens/filter_meals_screen.dart';

class FilterMealStateNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterMealStateNotifier()
    : super({
        Filter.gluten: false,
        Filter.lactose: false,
        Filter.vegan: false,
        Filter.vegetarian: false,
      });

  void switchFilter(Filter filter, bool isChecked) {
    state = {...state, filter: isChecked};
  }
}

final filterMealProvider = StateNotifierProvider((ref) {
  return FilterMealStateNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final filters = ref.watch(filterMealProvider);
  
  
  return ref.read(mealsProvider).where((meal) {
      if ((filters[Filter.gluten] ?? false) && !meal.isGlutenFree) {
        return false;
      }

      if ((filters[Filter.lactose] ?? false) && !meal.isLactoseFree) {
        return false;
      }

      if ((filters[Filter.vegan] ?? false) && !meal.isVegan) {
        return false;
      }

      if ((filters[Filter.vegetarian] ?? false) && !meal.isVegetarian) {
        return false;
      }

      return true;
    }).toList();
});