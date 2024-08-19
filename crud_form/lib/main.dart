import 'package:crud_form/pages/home_page1.dart';
import 'package:crud_form/themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Form',
      theme: lightTheme,
      home: const MyHomePage(),
    );
  }
}
