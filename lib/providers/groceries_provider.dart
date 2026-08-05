import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/model/grocery_item.dart';

class GroceriesStateNotifier extends StateNotifier<List<GroceryItem>> {
  GroceriesStateNotifier() : super([]);

  bool addGroceries(GroceryItem grocery) {
    if (state.contains(grocery)) return false;

    state = [...state, grocery];

    return true;
  }

  bool removeGroceries(GroceryItem grocery) {
    bool result = state.remove(grocery);
    state = [...state];

    return result;
  }
}

final groceriesProvider =
    StateNotifierProvider<GroceriesStateNotifier, List<GroceryItem>>((ref) {
      return GroceriesStateNotifier();
    });
