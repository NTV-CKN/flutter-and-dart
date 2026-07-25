import 'package:flutter/material.dart';
import 'package:second_app/button_stateful.dart';

class UIUpdatesDemo extends StatefulWidget {
  const UIUpdatesDemo({super.key});

  @override
  StatefulElement createElement() {
    print('UIUpdatesDemo createElement called');
    return super.createElement();
  }

  @override
  // ignore: no_logic_in_create_state
  State<UIUpdatesDemo> createState() {
    print('UIUpdatesDemo createState called');
    return _UIUpdatesDemo();
  }
}

class _UIUpdatesDemo extends State<UIUpdatesDemo> {
  @override
  void initState() {
    print('UIUpdatesDemo initState called');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('UIUpdatesDemo didChangeDependencies called');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant UIUpdatesDemo oldWidget) {
    print('UIUpdatesDemo didUpdateWidget called');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    print('UIUpdatesDemo setState called');
    super.setState(fn);
  }

  @override
  void deactivate() {
    print('UIUpdatesDemo deactivate called');
    super.deactivate();
  }

  @override
  void dispose() {
    print('UIUpdatesDemo dispose called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('UIUpdatesDemo BUILD called');

    //register dependency MediaQuery
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(),
            const Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ButtonStateful(),
          ],
        ),
      ),
    );
  }
}
