import 'package:flutter/material.dart';
import 'package:second_app/models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 4,
      child: Stack(
        children: [
          FadeInImage.assetNetwork(
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: 'assets/images/loading.gif',
            image: meal.imageUrl,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: const Color.fromARGB(67, 0, 0, 0),
              child: Text(
                meal.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                splashColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withAlpha(140),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
