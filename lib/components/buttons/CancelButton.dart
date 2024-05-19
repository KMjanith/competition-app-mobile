import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 30),
          ),
          backgroundColor:
              MaterialStatePropertyAll(Color.fromARGB(255, 138, 40, 40))),
      onPressed: () {
        print("cancelled");
      },
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
