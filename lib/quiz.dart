import 'package:flutter/material.dart';
import 'package:second_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  final colorsGradient = [Colors.deepPurpleAccent, Colors.indigo];

  Widget? showWidget;

  void navigate(Widget widget) {
    setState(() {
      showWidget = widget;
    });
  }

  @override
  void initState() {
    showWidget = StartScreen(navigate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colorsGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: showWidget,
        ),
      ),
    );
  }
}
