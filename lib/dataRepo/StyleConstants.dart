import 'package:flutter/material.dart';

class StyleConstants {
  // Prevent instantiation of the class
  StyleConstants._();

  static BoxDecoration pageBackground = const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromARGB(255, 211, 217, 252),
      Color.fromARGB(255, 142, 200, 255),
      Color.fromARGB(255, 130, 138, 255),
      Color.fromARGB(255, 255, 143, 195)
    ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
  );

  static LinearGradient cardBackGround = const LinearGradient(
    colors: [Color.fromARGB(255, 51, 172, 241), Color.fromARGB(255, 55, 66, 231), Color.fromARGB(255, 251, 39, 255)],
    stops: [0.1, 0.5, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
