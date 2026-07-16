import 'package:flutter/material.dart';
import 'package:second_app/answer_button.dart';
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

  //Tạo Text Widget
  Text generateText(
    String title, {
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
      ),
      textAlign: textAlign,
    );
  }

  //Tạo Danh sách các Widgets
  List<Widget> generateQuestions(QuizQuestion quiz, BuildContext ctx) {
    List<Widget> results = [];

    results.add(
      generateText(
        quiz.questionText,
        fontSize: 28,
        color: Colors.white,
        textAlign: TextAlign.center,
      ),
    );

    results.add(
      SizedBox(
        height: 20,
      ),
    );

    final copyList = quiz.getShuffleAnswer();

    for (var element in copyList) {
      results.add(
        AnswerButton(
          generateText(
            element,
            fontSize: 18,
          ),
          element,
          onButtonAnswerTapped: onButtonAnswerTapped,
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

  void onButtonAnswerTapped(String answer) {
    setState(() {
      if (currentPos == maxSizeQuestion - 1) {
        return;
      }
      currentPos++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
      ),
    );
  }
}
