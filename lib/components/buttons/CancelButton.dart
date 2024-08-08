import 'package:flutter/material.dart';

import '../Constants/StyleConstants.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 19),
      child: Container(
        decoration: BoxDecoration(
            gradient: StyleConstants.cancelButtonColor,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        width: 100,
        height: 60,
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
