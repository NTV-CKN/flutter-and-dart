import 'package:flutter/material.dart';
import 'package:second_app/widget/expenses_screen.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 90, 179, 207),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: ThemeData().cardTheme.copyWith(
          color: kDarkColorScheme.primaryContainer,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 0,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          foregroundColor: kColorScheme.primaryContainer,
          backgroundColor: kColorScheme.onPrimaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        cardTheme: ThemeData().cardTheme.copyWith(
          color: kColorScheme.primaryContainer,
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 0,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: ThemeData().textTheme.titleLarge?.copyWith(
            color: kColorScheme.onSecondaryContainer,
            fontSize: 24,
          ),
          titleMedium: ThemeData().textTheme.titleMedium?.copyWith(
            color: kColorScheme.onSecondaryContainer,
          ),
          titleSmall: ThemeData().textTheme.titleSmall?.copyWith(
            color: kColorScheme.onSecondaryContainer,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ExpensesScreen(),
      themeMode: ThemeMode.system,
    ),
  );
}
