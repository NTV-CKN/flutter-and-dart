import 'package:flutter/material.dart';

//Có thể dùng stateless vì chỉ có logic xử lí sự kiện nút nhấn
class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
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
            color: const Color.fromARGB(217, 255, 255, 255),
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
