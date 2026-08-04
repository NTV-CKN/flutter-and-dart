import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/data/dummy_categories.dart';

final categoriesProvider = Provider((ref) {
  return categories;
});