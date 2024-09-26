import 'package:flutter/material.dart';


class CustomListTitleSideBar extends StatelessWidget {
  final dynamic title;
  final Widget? leading;
  final IconData icon; // IconData should be dynamic

  const CustomListTitleSideBar({
    super.key,
    required this.title,
    this.leading,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading ?? SizedBox(
        width: 34,
        height: 34,
        child: Icon(icon, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontFamily: 'Poppins-Regular'),
      ),
    );
  }
}
