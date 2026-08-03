import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/data/dummy_categories.dart';
import 'package:second_app/providers/state_notifier/favorite_meal_provider.dart';
import 'package:second_app/providers/state_notifier/filter_meal_provider.dart';
import 'package:second_app/screens/categories_screen.dart';
import 'package:second_app/screens/filter_meals_screen.dart';
import 'package:second_app/screens/meals_screen.dart';
import 'package:second_app/widgets/main_drawer.dart';

class TabBasedScreen extends ConsumerStatefulWidget {
  const TabBasedScreen({super.key});

  @override
  ConsumerState<TabBasedScreen> createState() {
    return _TabBasedScreenState();
  }
}

class _TabBasedScreenState extends ConsumerState<TabBasedScreen> {
  final titles = ['Pick your category', 'Favorites'];

  int _currentSelected = 0;
  late String title = titles[0];

  void _navigateBottom(int index) {
    setState(() {
      _currentSelected = index;
      title = titles[index];
    });
  }

  void _actionTapDrawerItem(String typeItem) async {
    Navigator.of(context).pop();
    if (typeItem.toLowerCase() == 'meals') {
    } else if (typeItem.toLowerCase() == 'filters') {
      await Navigator.of(
        context,
      ).push(
        MaterialPageRoute(
          builder: (ctx) => FilterMealsScreen(),
        ),
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final mealAvailable = ref.watch(filteredMealsProvider);

    Widget content = CategoriesScreen(
      categories: availableCategories,
      meals: mealAvailable,
    );

    if (_currentSelected == 1) {
      content = MealsScreen(
        meals: favoriteMeals,
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
