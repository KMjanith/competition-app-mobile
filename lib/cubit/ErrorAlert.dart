import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorAlert extends StatelessWidget {
  final String description;
  const ErrorAlert({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 255, 147, 139),
      title: Text(
        "Error",
        style: GoogleFonts.akayaTelivigala(fontSize: 30),
      ),
      content: Text(description, style:GoogleFonts.asap(fontSize: 20)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK", style:GoogleFonts.asap(fontSize: 20))
        ),
      ],
    );
  }
}
