import 'package:flutter/material.dart';
import 'package:second_app/models/meal.dart';
import 'package:second_app/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({super.key, required this.meal});

  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String get complexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

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
              padding: EdgeInsets.symmetric(vertical: 10),
              color: const Color.fromARGB(67, 0, 0, 0),
              child: Column(
                children: [
                  Text(
                    meal.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MealItemTrait(
                        iconData: Icons.access_time_outlined,
                        label: '${meal.duration} min',
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      MealItemTrait(
                        iconData: Icons.hub_outlined,
                        label: complexity,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      MealItemTrait(
                        iconData: Icons.monetization_on_outlined,
                        label: affordability,
                      ),
                    ],
                  ),
                ],
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
