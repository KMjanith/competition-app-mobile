import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const InputField(
      {super.key, required this.labelText, required this.controller, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hoverColor: Colors.red,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: labelText,
          hintText: "Enter $labelText",
        ),
        controller: controller,
      ),
    );
  }
}
