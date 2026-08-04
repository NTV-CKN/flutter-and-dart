import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:second_app/screens/groceries.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 99, 159, 171),
);

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          textTheme: TextTheme().copyWith(
            titleLarge: TextStyle().copyWith(
              color: kColorScheme.onPrimary,
            ),
          ),
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.onPrimary,
          ),
        ),
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Groceries();
  }
}
