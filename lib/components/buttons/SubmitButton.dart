import "package:flutter/material.dart";
import "../Constants/StyleConstants.dart";

class SubmitButton extends StatelessWidget {
  final VoidCallback? addStudent;
  final String title;

  const SubmitButton({super.key, this.addStudent, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 19, right: 10),
        child: Container(
          decoration: BoxDecoration(
              gradient: StyleConstants.submitButtonColor,
              borderRadius: const BorderRadius.all(Radius.circular(16))),
          width: 300,
          height: 60,
          child: TextButton(
            onPressed: () {
              addStudent?.call(); // Correctly calling the method
            },
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
