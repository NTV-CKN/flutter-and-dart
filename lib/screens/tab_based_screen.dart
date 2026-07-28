import 'package:flutter/material.dart';
import 'package:second_app/data/dummy_categories.dart';
import 'package:second_app/data/dummy_meals.dart';
import 'package:second_app/screens/categories_screen.dart';
import 'package:second_app/screens/meals_screen.dart';

class TabBasedScreen extends StatefulWidget {
  const TabBasedScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabBasedScreenState();
  }
}

class _TabBasedScreenState extends State<TabBasedScreen> {
  final screens = [
    CategoriesScreen(categories: availableCategories, meals: dummyMeals),
    //temp
    MealsScreen(meals: []),
  ];

  final titles = ['Pick your category', 'Favorites'];

  int _currentSelected = 0;
  late String title = titles[0];

  void _navigateBottom(int index) {
    setState(() {
      _currentSelected = index;
      title = titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = screens[_currentSelected];

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
