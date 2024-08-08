import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
      child: Row(
        children: [
          const IconButton(onPressed: null,
           tooltip: 'Navigation Menu',
            icon: Icon(Icons.menu),
            ),
            Expanded(
              child: title,
            ),
            const IconButton(onPressed: null, icon: Icon(Icons.search), tooltip: 'Search',)
        ],
        ),
    );
  }
}
class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        MyAppBar(
          title: Text(
            'Shopping Mall',
            style: Theme.of(context).primaryTextTheme.titleLarge,
          ),
        ),
        const Expanded(
          child: Text('Product List', textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}