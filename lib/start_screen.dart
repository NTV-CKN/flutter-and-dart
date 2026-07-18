import 'package:flutter/material.dart';
import 'package:second_app/questions_screen.dart';
import 'package:google_fonts/google_fonts.dart';

//Có thể dùng stateless vì chỉ có logic xử lí sự kiện nút nhấn
// ignore: must_be_immutable
class StartScreen extends StatefulWidget {
  final void Function(Widget widget) navigate;

  const StartScreen(this.navigate, {super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _StartScreenState.navigate(navigate);
  }
}

class _StartScreenState extends State<StartScreen> {
  final void Function(Widget widget) navigate;

  _StartScreenState.navigate(this.navigate);

  void onStartQuiz() {
    navigate(QuestionScreen.navigate(navigate));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 200,
            color: const Color.fromARGB(217, 255, 255, 255),
          ),

          SizedBox(
            height: 20,
          ),

          Text(
            'Learn Flutte the !fun way!',
            style: GoogleFonts.playwriteAr(
              color: Colors.white,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(color: Colors.white, width: 2),
            ),
            icon: Icon(
              Icons.arrow_right_alt,
              size: 24,
            ),
            onPressed: onStartQuiz,
            label: const Text(
              'Start Quiz',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
