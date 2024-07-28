
import 'package:flutter/material.dart';

class StraightLineUpper extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Set the line color
      ..strokeWidth = 2.0; // Adjust line thickness as needed

     canvas.drawLine(Offset(60, 20.0), Offset(160, 20.0), paint);
     canvas.drawLine(Offset(160, 0.0), Offset(160, 20.0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
