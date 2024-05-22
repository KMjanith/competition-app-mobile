import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;
  const SubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 30),
          ),
          backgroundColor: MaterialStatePropertyAll(Colors.green)),
      onPressed: () {
        onPressed();
      },
      child: const Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
