import 'package:flutter/material.dart';

class StyleConstants {
  // Prevent instantiation of the class
  StyleConstants._();

  static BoxDecoration pageBackground = const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromARGB(255, 20, 7, 66),
      Color.fromARGB(255, 31, 11, 104),
      Color.fromARGB(255, 152, 6, 165),
      Color.fromARGB(255, 101, 0, 110)
    ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
  );

  static LinearGradient cardBackGround = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 123, 213, 255),
      Color.fromARGB(255, 86, 0, 121),
      Color.fromARGB(255, 145, 0, 73), // Darker color
    ],
    stops: [0.2, 0.5, 0.9],
  );
}
