import 'package:flutter/material.dart';

class AppConstants {
  // Prevent instantiation of the class
  AppConstants._();

  static const List<DropdownMenuItem<String>> grade = [
     DropdownMenuItem(value: "grade 1", child: Text("grade 1")),
     DropdownMenuItem(value: "grade 2", child: Text("grade 2")),
     DropdownMenuItem(value: "grade 3", child: Text("grade 3")),
     DropdownMenuItem(value: "grade 4", child: Text("grade 4")),
     DropdownMenuItem(value: "grade 5", child: Text("grade 5")),
     DropdownMenuItem(value: "grade 6", child: Text("grade 6")),
  ];
}