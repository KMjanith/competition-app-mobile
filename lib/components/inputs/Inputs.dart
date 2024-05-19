import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final String labelText;
  const InputField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hoverColor: Colors.red,
            filled: true,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: labelText,
            hintText: "Enter $labelText",
          ),
        ),
      
    );
  }
}
