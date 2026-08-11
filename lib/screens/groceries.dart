import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/providers/groceries_provider.dart';
import 'package:second_app/screens/add_grocery.dart';
import 'package:second_app/widgets/category_item.dart';

class Groceries extends ConsumerStatefulWidget {
  const Groceries({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _Groceries();
  }
}

class _Groceries extends ConsumerState<Groceries> {
  void _navigateNewGrocery(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) => AddGrocery(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(groceriesProvider.notifier).loadGroceries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groceries = ref.watch(groceriesProvider);
    final isLoading = ref.watch(isLoadingProvider);

    Widget content;

    if (isLoading) {
      content = Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      content = Center(
        child: Text(
          'Nothing here...',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      );
    }

    if (groceries.isNotEmpty) {
      content = ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(groceries[index].id),
          child: GroceryItem(groceries[index]),
          onDismissed: (direction) {
            final grocery = groceries[index];
            bool result = ref
                .read(groceriesProvider.notifier)
                .removeGroceries(grocery);
            if (result) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Removed',
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      ref
                          .read(groceriesProvider.notifier)
                          .addGroceries(grocery);
                    },
                  ),
                ),
              );
            }
          },
        ),
      );
    }

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
      body: content,
    );
  }
}
