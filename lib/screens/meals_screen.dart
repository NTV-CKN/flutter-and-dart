import 'package:flutter/material.dart';
import 'package:second_app/models/meal.dart';
import 'package:second_app/screens/meal_detail_screen.dart';
import 'package:second_app/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  final List<Meal> meals;
  final String? title;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  Future<void> _navigateDetailMeal(BuildContext ctx, Meal meal) async {
    await Navigator.push<void>(
      ctx,
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        navigateDetailMeal: (meal) {
          _navigateDetailMeal(ctx, meal);
        },
      ),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nothing here...',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 40,
            ),
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/10575/10575628.png',
              width: 80,
              height: 80,
            ),
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: content,
    );
  }
}
