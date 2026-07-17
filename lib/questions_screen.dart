import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_app/answer_button.dart';
import 'package:second_app/data/mock_quiz_question.dart';
import 'package:second_app/model/quiz_question.dart';
import 'package:second_app/start_screen.dart';

// ignore: must_be_immutable
class QuestionScreen extends StatefulWidget {
  final void Function(Widget widget) navigate;
  void Function(String answer)? onAnswerButtonClick;

  QuestionScreen.navigate(this.navigate, {super.key, this.onAnswerButtonClick});

  void setOnAnswerButtonClick(
    void Function(String answer) onAnswerButtonClick,
  ) {
    this.onAnswerButtonClick = onAnswerButtonClick;
  }

  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState.navigate();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  final int maxSizeQuestion = questions.length;

  int currentPos = 0;

  _QuestionScreenState.navigate();

  //Tạo Text Widget
  Text generateText(
    String title, {
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
  }) {
    return Text(
      title,
      style: GoogleFonts.geist(
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
      if (currentPos >= maxSizeQuestion) {
        return;
      }

      if (currentPos == maxSizeQuestion - 1) {
        widget.onAnswerButtonClick?.call(answer);
        //Xử lí điều hướng kết quả
        return;
      }

      widget.onAnswerButtonClick?.call(answer);
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
            Align(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white, width: 2),
                ),
                onPressed: () {
                  widget.navigate.call(StartScreen(widget.navigate));
                },
                icon: Icon(
                  Icons.exit_to_app,
                ),
                label: Text(
                  'Exit',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
