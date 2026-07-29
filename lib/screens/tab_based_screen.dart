import 'package:flutter/material.dart';
import 'package:second_app/data/dummy_categories.dart';
import 'package:second_app/data/dummy_meals.dart';
import 'package:second_app/models/meal.dart';
import 'package:second_app/screens/categories_screen.dart';
import 'package:second_app/screens/filter_meals_screen.dart';
import 'package:second_app/screens/meals_screen.dart';
import 'package:second_app/widgets/main_drawer.dart';

class TabBasedScreen extends StatefulWidget {
  const TabBasedScreen({super.key});

  @override
  State<TabBasedScreen> createState() {
    return _TabBasedScreenState();
  }
}

class _TabBasedScreenState extends State<TabBasedScreen> {
  final List<Meal> favoriteMeals = [];

  final titles = ['Pick your category', 'Favorites'];

  int _currentSelected = 0;
  late String title = titles[0];

  void _navigateBottom(int index) {
    setState(() {
      _currentSelected = index;
      title = titles[index];
    });
  }

  void _actionFavorite(Meal meal) {
    final isFavorite = favoriteMeals.contains(meal);
    if (isFavorite) {
      favoriteMeals.remove(meal);
    } else {
      favoriteMeals.add(meal);
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Remove success' : 'Add success',
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _actionSetState() {
    setState(() {});
  }

  void _actionTapDrawerItem(String typeItem) {
    Navigator.of(context).pop();
    if (typeItem.toLowerCase() == 'meals') {
    } else if (typeItem.toLowerCase() == 'filters') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (ctx) => FilterMealsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = CategoriesScreen(
      categories: availableCategories,
      meals: dummyMeals,
      actionFavorite: _actionFavorite,
      actionSetState: _actionSetState,
    );

    if (_currentSelected == 1) {
      content = MealsScreen(
        meals: favoriteMeals,
        actionFavorite: _actionFavorite,
        actionSetState: _actionSetState,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      drawer: MainDrawer(
        actionTapDrawerItem: _actionTapDrawerItem,
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigateBottom,
        currentIndex: _currentSelected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal_outlined),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
