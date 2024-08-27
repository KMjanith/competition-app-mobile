import 'package:flutter/material.dart';

class CoachingPlayerTitle extends StatelessWidget {
  final String title;
  const CoachingPlayerTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Color.fromARGB(166, 5, 180, 233),
          borderRadius: BorderRadius.circular(20)),
      child:  Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8, right: 12, left: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
