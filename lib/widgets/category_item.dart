import 'package:flutter/material.dart';
import 'package:second_app/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final void Function(Category category) navMeals;

  const CategoryItem({
    super.key,
    required this.category,
    required this.navMeals,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navMeals.call(category);
      },
      splashColor: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha(150),
              category.color.withAlpha(250),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(24),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
