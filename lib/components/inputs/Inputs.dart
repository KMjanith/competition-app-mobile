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
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No border side color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.transparent), // Transparent border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: Colors.transparent), // Transparent border
          ),
          filled: true,
          fillColor: Color.fromARGB(64, 139, 139, 139),
          labelText: labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 252, 252, 252)),

          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)), // Hint text style
        ),
        controller: controller,
        style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255)), // Text input style
      ),
    );
  }
}
