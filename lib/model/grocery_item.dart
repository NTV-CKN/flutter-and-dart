import 'package:second_app/model/category.dart';

class GroceryItem {
  final String id, name;
  final int quantity;
  final Category category;

  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  @override
  bool operator ==(Object other) {
    if (other is! GroceryItem) return false;

    if (identical(this, other)) return true;

    return id == other.id;
  }
}
