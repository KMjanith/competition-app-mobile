import 'package:flutter/material.dart';

class StyleConstants {
  // Prevent instantiation of the class
  StyleConstants._();

  static BoxDecoration pageBackground =
      const BoxDecoration(color: Color.fromARGB(255, 238, 238, 238));

  static Container upperBackgroundContainer = Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(gradient: lowerBackgroundColor),
  );

  static LinearGradient upperBackgroundColor = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 0, 20, 26),
        Color.fromARGB(255, 0, 0, 0),
        Color.fromARGB(255, 0, 16, 17),
      ]);

  static LinearGradient lowerBackgroundColor = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 0, 30, 37),
        Color.fromARGB(255, 0, 32, 30),
        Color.fromARGB(255, 0, 36, 46)
      ]);

  static LinearGradient homeCardGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(162, 83, 236, 247),
      Color.fromARGB(255, 117, 247, 236),
      Color.fromARGB(120, 146, 248, 240),
    ],
  );

  static Positioned lowerBackgroundContainer = Positioned(
      child: Container(
    height: 450,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        gradient: upperBackgroundColor),
  ));

  static LinearGradient cardBackGround = const LinearGradient(
    colors: [
      Color.fromARGB(255, 159, 212, 247),
      Color.fromARGB(255, 121, 175, 236)
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
   
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static LinearGradient falseTileBackground = const LinearGradient(
    colors: [
      Color.fromARGB(255, 247, 130, 130),
      Color.fromARGB(255, 255, 162, 162)
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
