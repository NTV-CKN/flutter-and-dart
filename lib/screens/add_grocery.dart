import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/data/dummy_categories.dart';
import 'package:second_app/model/category.dart';
import 'package:second_app/model/grocery_item.dart';
import 'package:second_app/providers/categories_provider.dart';
import 'package:second_app/providers/groceries_provider.dart';
import 'package:second_app/widgets/progress_loading.dart';

class AddGrocery extends ConsumerStatefulWidget {
  const AddGrocery({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddGroceryState();
  }
}

class _AddGroceryState extends ConsumerState<AddGrocery> {
  late final GlobalKey<FormState> _globalKey;
  String _nameGrocery = '';
  int _quantity = 1;
  Category _category = categories[Categories.carbs]!;

  void _handleAddGrocery() async {
    if (_globalKey.currentState != null &&
        _globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();

      showDialogLoading(context);

      bool result = await ref
          .read(groceriesProvider.notifier)
          .addGroceries(
            GroceryItem(
              id: DateTime.now().toString(),
              name: _nameGrocery,
              quantity: _quantity,
              category: _category,
            ),
          );

      if (!mounted) {
        return;
      }

      hideDialogLoading(context);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result ? 'Add Successful' : 'Add Failed',
          ),
        ),
      );
    }
  }

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
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length > 40) {
                    return 'Illegal length of name grocery';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _nameGrocery = newValue!;
                },
                maxLength: 40,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Illegal quantity of grocery';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _quantity = int.tryParse(newValue!)!;
                      },
                      decoration: InputDecoration(
                        hintText: 'Quantity',
                      ),
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<Category?>(
                      initialValue: _category,
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
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _category = value;
                        });
                      },
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
                    onPressed: () {
                      _globalKey.currentState?.reset();
                    },
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
                    child: const Text('Reset'),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    onPressed: _handleAddGrocery,
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
                    child: const Text('Add'),
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
