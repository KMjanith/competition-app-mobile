import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 4.0, right: 35),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 184, 37, 0),
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
