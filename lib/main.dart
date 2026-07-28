import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_app/screens/tab_based_screen.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 117, 171, 236),
);

final theme = ThemeData(
  colorScheme: kColorScheme,
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(
    Main(),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: kColorScheme,
        textTheme: GoogleFonts.latoTextTheme(),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          foregroundColor: kColorScheme.onPrimary,
        ),
      ),
      home: TabBasedScreen(),
    );
  }
}
