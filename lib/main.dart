import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 161, 123, 238),
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
      theme: theme,
      home: Scaffold(
        body: Text('Hello world!'),
      ),
    );
  }
}
