import 'package:flutter/material.dart';

class StyleConstants {
  // Prevent instantiation of the class
  StyleConstants._();

  static BoxDecoration pageBackground = const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromARGB(255, 202, 210, 255),
      Color.fromARGB(255, 118, 189, 255),
      Color.fromARGB(255, 245, 130, 255),
      Color.fromARGB(255, 255, 81, 162)
    ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
  );

  static LinearGradient cardBackGround = const LinearGradient(
    colors: [Color.fromARGB(255, 51, 172, 241), Color.fromARGB(255, 55, 66, 231), Color.fromARGB(255, 251, 39, 255)],
    stops: [0.1, 0.5, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
