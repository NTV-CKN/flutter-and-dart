import 'package:second_app/model/category.dart';

class GroceryItem {
  String id, name;
  int quantity;
  Category category;

  GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  factory GroceryItem.fromJson(Map<String, dynamic> map, String key) {
    return GroceryItem(
      id: key,
      name: map['name'],
      quantity: map['quantity'],
      category: Category.fromJson(map['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
