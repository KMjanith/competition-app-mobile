import 'package:flutter/material.dart';

class BottomLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue // Set the line color
      ..strokeWidth = 2.0; // Adjust line thickness as needed

    canvas.drawLine(Offset(110, 0.0), Offset(110, 20.0), paint);
    canvas.drawLine(Offset(60, 20.0), Offset(110, 20.0), paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
