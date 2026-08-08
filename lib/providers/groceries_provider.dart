import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/env/env.dart';
import 'package:second_app/model/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceriesStateNotifier extends StateNotifier<List<GroceryItem>> {
  GroceriesStateNotifier() : super([]);

  void loadGroceries() async {
    final uri = Uri.https(Env.baseUrl, 'groceries.json');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final map =
          json.decoder.convert(response.body)
              as Map<String, dynamic>;

      final List<GroceryItem> groceries = [];
      for (var entry in map.entries) {
        groceries.add(GroceryItem.fromJson(entry.value));
      }

      state = groceries;
    } else {
      state = [];
    }
  }

  Future<bool> addGroceries(GroceryItem grocery) async {
    final uri = Uri.https(Env.baseUrl, 'groceries.json');

    final response = await http.post(uri, body: json.encoder.convert(grocery));

    return response.statusCode == 200;
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
