import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final String role;

  const InfoCard({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Iconsax.user_bold, color: Colors.black),
          ),
          title: Text(
            name,
            style: const TextStyle(fontFamily: 'Poppins', fontSize: 18),
          ),
          subtitle: Text(
            role,
            style: const TextStyle(fontSize: 14, fontFamily: 'Poppins-Regular'),
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
