import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/data/dummy_meals.dart';
import 'package:second_app/models/meal.dart';

final mealsProvider = Provider<List<Meal>>((ref) {
  return dummyMeals;
});
