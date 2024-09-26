import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final IconData icon;
  final double size;
  const CustomLogo({super.key, required this.icon, required this.size});
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
    );
  }
}