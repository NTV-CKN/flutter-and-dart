import 'package:flutter/material.dart';
import 'package:second_app/roll_dice_widget.dart';

class MyHomeWidget extends StatelessWidget {
  final List<Color> _colors;

  static const startAlignment = Alignment.topLeft;
  static const endAlignment = Alignment.bottomRight;

  const MyHomeWidget.titleColors(this._colors, {super.key});

  void handleRollDiceClick() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _colors,
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(
        child: RollDice(6),
      ),
    );
  }
}
