import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/providers/groceries_provider.dart';
import 'package:second_app/screens/add_grocery.dart';
import 'package:second_app/widgets/category_item.dart';

class Groceries extends ConsumerWidget {
  const Groceries({super.key});

  void _navigateNewGrocery(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => AddGrocery(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceries = ref.watch(groceriesProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _navigateNewGrocery(context),
            icon: Icon(Icons.add),
          ),
        ],
        title: Text(
          'Your Groceries',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (ctx, index) => GroceryItem(groceries[index]),
      ),
    );
  }
}
