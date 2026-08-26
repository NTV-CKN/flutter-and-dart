import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/env/env.dart';
import 'package:second_app/model/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceriesStateNotifier extends StateNotifier<List<GroceryItem>> {
  final Ref ref;

  GroceriesStateNotifier(this.ref) : super([]);

  void loadGroceries() async {
    ref.read(isLoadingProvider.notifier).state = true;

    try {
      final uri = Uri.https(Env.baseUrl, 'groceries.json');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final map = json.decoder.convert(response.body) as Map<String, dynamic>;

        final List<GroceryItem> groceries = [];
        for (var entry in map.entries) {
          groceries.add(GroceryItem.fromJson(entry.value, entry.key));
        }

        state = groceries;
      } else {
        state = [];
      }
    } catch (_) {
    } finally {
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  Future<bool> addGroceries(GroceryItem grocery) async {
    final uri = Uri.https(Env.baseUrl, 'groceries.json');

    final response = await http.post(uri, body: json.encoder.convert(grocery));

    if (response.statusCode == 200) {
      final result =
          json.decoder.convert(response.body) as Map<String, dynamic>;
      grocery.id = result['name'];
      state = [...state, grocery];
    }

    return response.statusCode == 200;
  }

  Future<bool> removeGroceries(GroceryItem grocery, int index) async {
    state.remove(grocery);
    state = [...state];

    try {
      final response = await http.delete(
        Uri.https(Env.baseUrl, 'groceries/${grocery.id}.json'),
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return true;
      }

      state.add(grocery);
      state = [...state];

      return false;
    } catch (e) {
      state.add(grocery);
      state = [...state];

      print(e);
      return false;
    }
  }
}

final groceriesProvider =
    StateNotifierProvider<GroceriesStateNotifier, List<GroceryItem>>((ref) {
      return GroceriesStateNotifier(ref);
    });

final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});
