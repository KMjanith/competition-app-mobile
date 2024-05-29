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
    colors: [Color(0xff83c2e7), Color(0xff6168e5), Color(0xffd348d5)],
    stops: [0.1, 0.5, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
