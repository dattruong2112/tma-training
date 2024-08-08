import 'package:flutter/material.dart';


class Statefuldemo1App extends StatelessWidget {
  const Statefuldemo1App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldApp(),
    );
  }
}

class ScaffoldApp extends StatefulWidget {
  const ScaffoldApp({super.key});

  @override
  State<ScaffoldApp> createState() => _ScaffoldAppState();
}

class _ScaffoldAppState extends State<ScaffoldApp> {
  int _count = 0;
  String _rank = '';

  @override
  Widget build(BuildContext context) {
    _updateRank();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: Colors.blue[500],
            ),
          padding: EdgeInsets.all(50),
          margin: EdgeInsets.all(50),
          child: Text(
            'Press button challenge',
             style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
              ),
        )
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300,),
            Text('You have pressed the button $_count times.'),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text('Your currently rank is $_rank.'),
            ]
          ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _count++;
        }),
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  void _updateRank() {
  if (_count < 30) {
    _rank = 'No Rank';
    }
  else if (_count < 50) {
    _rank = 'Bronze';
    }
  else if (_count < 100) {
    _rank = 'Silver';
    }
  else  {
    _rank = 'Gold';
    }
  }
}

