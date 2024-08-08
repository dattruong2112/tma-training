import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({required this.title, super.key});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
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
          Container(
            child: Align(
              alignment: Alignment(0, 0),
              child: Text('Welcome to Lorem Ipsum', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),)
              ),
            ),
          const Expanded(
            child: Center(
              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus tellus lectus, ornare accumsan mi id, volutpat convallis lectus. Donec consequat ipsum non lorem pharetra venenatis sit amet at erat. Quisque sit amet commodo elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Morbi sed commodo arcu, quis aliquam metus. Suspendisse quis tellus sed massa hendrerit convallis. Ut ipsum elit, volutpat a blandit vitae, finibus quis sem. Morbi blandit, nunc iaculis pulvinar hendrerit, eros ex lacinia lectus, vel facilisis eros sem eget quam. Integer fringilla, libero eget dictum vulputate, tortor eros dapibus arcu, sit amet venenatis sem nulla sed ligula. Vivamus eu felis eleifend lorem molestie luctus et id velit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae',
               style: TextStyle(fontSize: 18,),
                textAlign: TextAlign.center,
                ),
            ),
          ),
        ],
      ),
    );
  }
}