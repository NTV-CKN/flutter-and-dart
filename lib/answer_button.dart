import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final Widget child;
  final String answer;
  final void Function(String answer) onButtonAnswerTapped;

  const AnswerButton(
    this.child,
    this.answer, {
    super.key,
    required this.onButtonAnswerTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fixedSize: Size.fromWidth(
          MediaQuery.of(context).size.width - 60,
        ),
        backgroundColor: const Color.fromARGB(255, 42, 15, 193),
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        onButtonAnswerTapped.call(answer);
      },
      child: child,
    );
  }
}
