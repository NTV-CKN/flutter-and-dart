import 'package:flutter/material.dart';

class ButtonStateful extends StatefulWidget {
  const ButtonStateful({super.key});

  @override
  State<ButtonStateful> createState() {
    return _ButtonStatefulState();
  }
}

class _ButtonStatefulState extends State<ButtonStateful> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    final widthSpace = MediaQuery.of(context).viewInsets.bottom;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  print('setState ButtonStateful');
                  _isUnderstood = false;
                });
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  print('setState ButtonStateful');
                  _isUnderstood = true;
                });
              },
              child: const Text('Yes'),
            ),
          ],
        ),
        if (_isUnderstood) const Text('Awesome!'),
      ],
    );
  }
}
