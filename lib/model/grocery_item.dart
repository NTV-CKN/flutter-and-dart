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

  factory GroceryItem.fromJson(Map<String, dynamic> map) {
    return GroceryItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      category: Category.fromJson(map['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category': category.toJson(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (other is! GroceryItem) return false;

    if (identical(this, other)) return true;

    return id == other.id;
  }
}
