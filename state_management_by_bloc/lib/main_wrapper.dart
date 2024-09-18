import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _mainWrapperAppBar(),
      body: Center(),
    );
  }

  AppBar _mainWrapperAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      title: const Text('Bottom Navigation Bar with Cubit'),
    );
  }
}
