import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(horizontal: 30),
          ),
          backgroundColor: MaterialStatePropertyAll(Colors.green)),
      onPressed: () {
        print("submited");
      },
      child: const Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
