import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final String labelText;
  const InputField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: labelText,
            hintText: "Enter $labelText",
          ),
        ),
      ),
    );
  }
}
