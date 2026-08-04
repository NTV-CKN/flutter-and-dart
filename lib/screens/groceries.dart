import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Groceries extends ConsumerWidget {
  const Groceries({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView(),
    );
  }
}
