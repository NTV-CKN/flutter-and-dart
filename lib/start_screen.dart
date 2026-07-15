import 'package:flutter/material.dart';

//Có thể dùng stateless vì chỉ có logic xử lí sự kiện nút nhấn
class HomeQuiz extends StatefulWidget {
  const HomeQuiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeQuizState();
  }
}

class _HomeQuizState extends State<HomeQuiz> {
  void onStartQuiz() {}

  @override
  Widget build(BuildContext context) {
    return Center(
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
