import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateWhiteButon extends StatelessWidget {
  final VoidCallback callback;
  final String buttonTitle;
  const CreateWhiteButon(
      {super.key, required this.callback, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(55, 0, 0, 0),
                offset: Offset(1, 4),
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          width: 160,
          height: 70,
          child: Center(
            child: TextButton(
              onPressed: callback,
              child: Text(
                buttonTitle,
                style: GoogleFonts.cairo(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        ));
  }
}
