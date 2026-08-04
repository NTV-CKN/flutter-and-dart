import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/data/dummy_items.dart';

final groceriesProvider = Provider((ref) {
  return groceryItems;
});