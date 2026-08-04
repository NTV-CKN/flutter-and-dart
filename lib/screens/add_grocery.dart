import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/model/category.dart';
import 'package:second_app/providers/categories_provider.dart';

class AddGrocery extends ConsumerStatefulWidget {
  const AddGrocery({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddGroceryState();
  }
}

class _AddGroceryState extends ConsumerState<AddGrocery> {
  late final GlobalKey<FormState> _globalKey;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new grocery',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name Grocery',
                ),
                validator: (value) {},
                maxLength: 40,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Quantity',
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<Category?>(
                      initialValue: null,
                      items: [
                        for (final entry in categories.entries)
                          DropdownMenuItem<Category?>(
                            key: ValueKey(entry.value),
                            value: entry.value,
                            child: Row(
                              children: [
                                Container(
                                  color: entry.value.color,
                                  width: 12,
                                  height: 12,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  entry.value.title,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(11),
                      ),
                    ),
                    child: Text('Reset'),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primary,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(11),
                      ),
                    ),
                    child: Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
