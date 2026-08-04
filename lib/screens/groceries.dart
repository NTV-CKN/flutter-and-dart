import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/providers/groceries_provider.dart';
import 'package:second_app/widgets/category_item.dart';

class Groceries extends ConsumerWidget {
  const Groceries({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceries = ref.watch(groceriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groceries',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          for (var grocery in groceries) GroceryItem(grocery),
        ],
      ),
    );
  }
}
