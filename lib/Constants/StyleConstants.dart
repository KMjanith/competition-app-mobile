import 'package:flutter/material.dart';

class StyleConstants {
  // Prevent instantiation of the class
  StyleConstants._();

  static BoxDecoration pageBackground = const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 164, 249, 255),
      Color.fromARGB(255, 132, 210, 255),
      Color.fromARGB(255, 117, 102, 255)
    ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
  );

  static LinearGradient cardBackGround = const LinearGradient(
    colors: [Color.fromARGB(255, 51, 172, 241), Color.fromARGB(255, 5, 19, 209), Color.fromARGB(255, 251, 39, 255)],
    stops: [0.1, 0.5, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient cancelButtonColor = const LinearGradient(
    colors: [Colors.red, Colors.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient submitButtonColor = const LinearGradient(
    colors: [Color.fromARGB(255, 185, 216, 12), Color.fromARGB(255, 1, 95, 4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
