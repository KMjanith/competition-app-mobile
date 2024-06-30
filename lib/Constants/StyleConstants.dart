import 'package:flutter/material.dart';

class StyleConstants {
  // Prevent instantiation of the class
  StyleConstants._();

  static BoxDecoration pageBackground =
      const BoxDecoration(color: Color.fromARGB(255, 238, 238, 238));

  static Container upperBackgroundContainer = Container(
    height: double.infinity,
    width: double.infinity,
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color.fromARGB(255, 18, 0, 20),
          Color.fromARGB(255, 38, 255, 244),
          Color.fromARGB(255, 1, 79, 102)
        ])),
  );

  static Positioned lowerBackgroundContainer = Positioned(
      child: Container(
    height: 450,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 61, 0, 71),
              Color.fromARGB(255, 238, 183, 183)
            ])),
  ));

  static LinearGradient cardBackGround = const LinearGradient(
    colors: [
      Color.fromARGB(255, 244, 232, 248),
      Color.fromARGB(255, 231, 190, 250),
      Color.fromARGB(255, 181, 222, 247),
      Color.fromARGB(255, 113, 193, 243)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient cancelButtonColor = const LinearGradient(
    colors: [
      Color.fromARGB(255, 236, 33, 18),
      Color.fromARGB(255, 167, 2, 131)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient submitButtonColor = const LinearGradient(
    colors: [Color.fromARGB(255, 185, 216, 12), Color.fromARGB(255, 1, 95, 4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient trueTileBackground = const LinearGradient(
    colors: [
      Color.fromARGB(255, 80, 255, 109),
      Color.fromARGB(255, 21, 196, 50),
      Color.fromARGB(255, 0, 134, 4)
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient falseTileBackground = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 167, 167),
      Color.fromARGB(255, 247, 130, 130),
      Color.fromARGB(255, 247, 111, 111)
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,

  );
}
