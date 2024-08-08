import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trainngwidget/statelessWidgetDemo1.dart';

void main() {
  runApp(
    const MaterialApp(
      home: SafeArea(child: MyScaffold(),),
      title: 'Demo1',
    ),
  );
}
