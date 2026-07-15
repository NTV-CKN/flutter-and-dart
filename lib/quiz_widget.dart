import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeQuiz extends StatefulWidget {
  final colorsGradient = [Colors.deepPurpleAccent, Colors.indigo];

  HomeQuiz({super.key});

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _HomeQuizState.colorsGradient(colorsGradient);
  }
}

class _HomeQuizState extends State<HomeQuiz> {
  List<Color> colorsGradient;

  _HomeQuizState.colorsGradient(this.colorsGradient);

  void onStartQuiz() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colorsGradient),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(
            '../assets/images/quiz-logo.png',
            width: 200,
          ),

          SizedBox(
            height: 20,
          ),

          const Text(
            'Learn Flutte the !fun way!',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white, width: 2),
            ),
            onPressed: onStartQuiz,
            child: const Text(
              'Start Quiz',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
