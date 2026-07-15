import 'package:flutter/material.dart';
import 'package:second_app/start_screen.dart';

void main() {
  final colorsGradient = [Colors.deepPurpleAccent, Colors.indigo];
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colorsGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const HomeQuiz(),
        ),
      ),
    ),
  );
}
