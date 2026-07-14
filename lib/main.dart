import 'package:flutter/material.dart';
import 'package:second_app/my_custom_widget.dart';

const colors = [Colors.deepPurple, Colors.indigo];

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: MyHomeWidget.titleColors(colors),
      ),
    ),
  );
}
