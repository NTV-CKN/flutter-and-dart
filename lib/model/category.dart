import 'package:flutter/services.dart';

enum Categories {
  vegetables, 
  fruit,
  meat,
  other,
  hygiene,
  convenience,
  spices,
  sweets,
  carbs,
  dairy
}

class Category {
  final String title;
  final Color color;

  const Category({required this.title, required this.color});
}
