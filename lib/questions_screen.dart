import 'package:flutter/material.dart';
import 'package:second_app/data/mock_quiz_question.dart';
import 'package:second_app/model/quiz_question.dart';
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
  final int maxSizeQuestion = questions.length;

  int currentPos = 0;

  _QuestionScreenState.navigate(this.navigate);

  List<Widget> generateQuestions(QuizQuestion quiz, BuildContext ctx) {
    List<Widget> results = [];

    results.add(
      Text(
        quiz.questionText,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          color: Colors.white,
        ),
      ),
    );

    results.add(
      SizedBox(
        height: 20,
      ),
    );

    for (var element in quiz.answers) {
      results.add(
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: Size.fromWidth(
              MediaQuery.of(ctx).size.width - 60,
            ),
            side: BorderSide(
              color: Colors.white,
              width: 2,
              strokeAlign: 2,
            ),
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
          child: Text(
            element,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );

      results.add(
        SizedBox(
          height: 15,
        ),
      );
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (Widget widget in generateQuestions(
            questions[currentPos],
            context,
          ))
            widget,
          SizedBox(
            height: 40,
          ),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
            ),
            onPressed: () {
              navigate.call(StartScreen(navigate));
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
            label: Text(
              'Exit',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
