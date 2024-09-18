import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          CupertinoIcons.antenna_radiowaves_left_right,
          size: 100.0,
          color: Colors.grey[600],
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          'Buy or sell more!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          'Here is your HomePage, you will be able to buy and sell products.',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
