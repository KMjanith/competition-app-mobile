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
      padding: const EdgeInsets.only(top:8.0,bottom: 0.8, left: 28, right: 28),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hoverColor: Colors.red,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          hintText: "Enter $labelText",
          hintStyle: const TextStyle(color: Color.fromARGB(179, 0, 0, 0)), // Hint text style
        ),
        controller: controller,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)), // Text input style
      ),
    );
  }
}
