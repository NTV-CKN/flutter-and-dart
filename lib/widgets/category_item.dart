import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/model/grocery_item.dart' as grocery;

class GroceryItem extends ConsumerWidget {
  final grocery.GroceryItem groceryItem;

  const GroceryItem(this.groceryItem, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: groceryItem.category.color,
              ),
            ),
            SizedBox(
              width: 18,
            ),
            Expanded(
              child: Text(
                groceryItem.name,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(right: 20),
              child: Text(
                groceryItem.quantity.toString(),
                style: TextStyle(
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
