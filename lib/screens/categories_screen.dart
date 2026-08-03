import 'package:flutter/material.dart';
import 'package:second_app/models/category.dart';
import 'package:second_app/models/meal.dart';
import 'package:second_app/screens/meals_screen.dart';
import 'package:second_app/widgets/category_item.dart';

class CategoriesScreen extends StatefulWidget {
  final List<Category> categories;
  final List<Meal> meals;

  const CategoriesScreen({
    super.key,
    required this.categories,
    required this.meals,
  });

  Future<void> _navigateMeals(BuildContext ctx, Category category) async {
    final mealsByCategory = meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    await Navigator.push<void>(
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
  State<StatefulWidget> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: widget.categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => CategoryItem(
          category: widget.categories[index],
          navMeals: (category) {
            widget._navigateMeals(ctx, category);
          },
        ),
      ),
      builder: (context, child) {
        return SlideTransition(
          position: _animationController.drive(
            Tween(
              begin: Offset(1, 0),
              end: Offset(0, 0),
            ),
          ),
          child: child,
        );
      },
    );
  }
}
