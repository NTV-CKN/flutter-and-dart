import 'package:flutter/material.dart';
import 'package:second_app/models/category.dart';
import 'package:second_app/models/meal.dart';
import 'package:second_app/screens/meals_screen.dart';
import 'package:second_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories;
  final List<Meal> meals;
  const CategoriesScreen({
    super.key,
    required this.categories,
    required this.meals,
  });

  void _navigateMeals(BuildContext ctx, Category category) {
    final mealsByCategory = meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: mealsByCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => CategoryItem(
        category: categories[index],
        navMeals: (category) {
          _navigateMeals(ctx, category);
        },
      ),
    );
  }
}
