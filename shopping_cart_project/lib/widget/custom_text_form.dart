import 'package:flutter/material.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController fullNameController = TextEditingController();

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CustomPasswordFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomPasswordFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      obscuringCharacter: '*',
      controller: controller,
      validator: validator ??
              (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black26,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12, // Default border color
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
