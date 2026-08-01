import 'package:flutter_riverpod/flutter_riverpod.dart';
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
