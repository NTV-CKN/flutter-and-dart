import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/models/meal.dart';

class _FavoriteMealsStateNotifier extends StateNotifier<List<Meal>> {
  _FavoriteMealsStateNotifier() : super([]);

  bool toggleAddFavoriteMeal(Meal meal) {
    final isMealInFavorite = state.contains(meal);

    if (isMealInFavorite) {
      state = state.where((item) => item.id != meal.id).toList();
      return false;
    }

    state = [...state, meal];
    return true;
  }
}

final favoriteMealsProvider = StateNotifierProvider((ref) {
  return _FavoriteMealsStateNotifier();
});
