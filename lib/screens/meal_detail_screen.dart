import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/models/meal.dart';
import 'package:second_app/providers/state_notifier/favorite_meal_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  final Meal meal;

  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  void _toggleAddFavoriteMeal(WidgetRef ref, BuildContext context) {
    final isSuccess = ref
        .read(favoriteMealsProvider.notifier)
        .toggleAddFavoriteMeal(meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isSuccess ? 'Add success' : 'Remove success',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _toggleAddFavoriteMeal(ref, context),
            icon: Icon(
              favoriteMeals.contains(meal) ? Icons.star : Icons.star_outline,
            ),
          ),
        ],
        title: Text(
          meal.title,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.all(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: meal.imageUrl,
              ),
            ),
            Text(
              'Ingredients',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            for (var ingredient in meal.ingredients)
              Text(
                ingredient,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 15,
                ),
              ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Steps',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.orange,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            for (var step in meal.steps)
              Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 15,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
