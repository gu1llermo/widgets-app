import 'package:flutter/material.dart';

const colors = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Color.fromARGB(255, 16, 192, 48),
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0,
            'selectedColor must be greater then or equal to 0'),
        assert(selectedColor < colors.length,
            'selectedColor must be less than ${colors.length}');

  ThemeData getTheme() => ThemeData(
      colorSchemeSeed: colors[selectedColor],
      appBarTheme: const AppBarTheme(centerTitle: false));
}
