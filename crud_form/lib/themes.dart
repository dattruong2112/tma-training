import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.blue,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.blue,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
  ),
);

TextStyle headerStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  fontFamily: 'Poppins-Light',
);
TextStyle bodyStyle = const TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Colors.black,
  fontFamily: 'Poppins-Light',
);