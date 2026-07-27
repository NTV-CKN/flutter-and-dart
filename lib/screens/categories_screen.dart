import 'package:flutter/material.dart';
import 'package:second_app/models/category.dart';
import 'package:second_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Category> categories;
  const CategoriesScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pick your category',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: GridView.builder(
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => CategoryItem(category: categories[index]),
      ),
    );
  }
}
