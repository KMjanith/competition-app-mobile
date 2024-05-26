import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hoverColor: Colors.red,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: "Enter $labelText",
          hintStyle: const TextStyle(color: Colors.white70), // Hint text style
        ),
        controller: controller,
        style: const TextStyle(color: Colors.white), // Text input style
      ),
    );
  }
}
