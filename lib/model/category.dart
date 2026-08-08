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
  dairy,
}

class Category {
  final String title;
  final Color color;

  const Category({required this.title, required this.color});

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      title: map['title'],
      color: Color(map['color'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'color': color.toARGB32(),
    };
  }
}
