import "package:flutter/material.dart";

class SubmitButton extends StatelessWidget {
  final VoidCallback? addStudent;
  const SubmitButton({super.key, this.addStudent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 4.0, left: 35),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 6, 177, 35),
          borderRadius: BorderRadius.circular(50),
        ),
        child: TextButton(
          onPressed: addStudent,
          child: const Text(
            "Submit",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
          ),
        ),
      ),
    );
  }
}
