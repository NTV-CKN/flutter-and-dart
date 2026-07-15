import 'package:flutter/material.dart';
import 'package:second_app/start_screen.dart';

class QuestionScreen extends StatefulWidget {
  final void Function(Widget widget) navigate;

  const QuestionScreen.navigate(this.navigate, {super.key});

  @override
  State<QuestionScreen> createState() {
    // ignore: no_logic_in_create_state
    return _QuestionScreenState.navigate(navigate);
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  final void Function(Widget widget) navigate;

  _QuestionScreenState.navigate(this.navigate);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
        ),
        onPressed: () {
          navigate.call(StartScreen(navigate));
        },
        child: Text(
          'Exit',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
