import 'package:flutter/material.dart';
import 'package:second_app/questions_screen.dart';
import 'package:second_app/results_screen.dart';
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
  final List<String> answersUserChoose = [];

  Widget? showWidget;

  void navigate(Widget widget) {
    setState(() {
      if (widget is QuestionScreen) {
        widget.setOnAnswerButtonClick(onAnswerButtonClick);
      }

      if (widget is ResultsScreen) {
        widget.sOnResultsScreenDispose = onResultsScreenDispose;
        widget.sAnswers = answersUserChoose;
      }

      showWidget = widget;
    });
  }

  void onResultsScreenDispose() {
    answersUserChoose.clear();
  }

  void onAnswerButtonClick(String answer) {
    answersUserChoose.add(answer);
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
