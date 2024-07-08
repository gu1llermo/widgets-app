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
  final bool darkMode;

  AppTheme({this.selectedColor = 0, this.darkMode = false})
      : assert(selectedColor >= 0,
            'selectedColor must be greater then or equal to 0'),
        assert(selectedColor < colors.length,
            'selectedColor must be less than ${colors.length}');

  ThemeData getTheme() => ThemeData(
        brightness: darkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colors[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  AppTheme copyWith({int? selectedColor, bool? darkMode}) => AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      darkMode: darkMode ?? this.darkMode);
}
