import 'dart:math';

import 'package:flutter/material.dart';
import 'package:second_app/image_custom_widget.dart';

class RollDice extends StatefulWidget {
  final int current;

  RollDice(this.current, {super.key}) {
    if (current > 6 || current < 1) throw Exception('Không hợp lệ');
  }

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _RollDiceState(current);
  }
}

class _RollDiceState extends State<RollDice> {
  final random = Random();

  int currentRoll;

  _RollDiceState(this.currentRoll);

  void onRollDice() {
    setState(() {
      while (true) {
        int tmp = random.nextInt(6) + 1;
        if (tmp != currentRoll) {
          currentRoll = tmp;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        ImageCustomWidget.option(
          option: ImageCustomWidget.assetsOption,
          source: '../assets/images/dice-$currentRoll.png',
        ),
        TextButton(
          onPressed: onRollDice,
          child: Text(
            'Roll Dice',
            style: TextStyle(fontSize: 28, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
