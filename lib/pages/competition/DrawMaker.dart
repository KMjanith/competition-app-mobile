import 'dart:developer';

import 'package:flutter/material.dart';

class DrawMaker extends StatelessWidget {
  const DrawMaker({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> participants = [
      'Player 1',
      'Player 2',
      'Player 3',
      'Player 4',
      'Player 5',
      'Player 6',
      'Player 7',
      'Player 8',
    ];
    final List<List<String>> rounds = generateCompetitionDraw(participants);

    return Scaffold(
      appBar: AppBar(
        title: Text('Competition Draw'),
      ),
      body: Center(
        child: CustomPaint(
          painter: CompetitionTreePainter(rounds),
          child: const Center(
            child: Text(
              'Once upon a time...',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompetitionTreePainter extends CustomPainter {
  final List<List<String>> rounds;

  CompetitionTreePainter(this.rounds);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;

    log("length: ${rounds.length}");
    log("size: $size");
    log("size.height: ${size.height}");
    log("size.width: ${size.width}");

    final double spacingX = size.width / (rounds.length + 1);
    final double spacingY = size.height / (rounds.first.length * 2);

    log("rounds.first.length: ${rounds.first.length}");

    log("spacingX: $spacingX");
    log("spacingY: $spacingY");
    for (int round = 0; round < rounds.length; round++) {
      final double x = spacingX * (round + 1);

      for (int i = 0; i < rounds[round].length; i++) {
        final double y = spacingY * (2 * i + 1);

        final TextSpan span = TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          text: rounds[round][i],
        );
        final TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height / 2));

        if (round < rounds.length - 1) {
          final double nextX1 = spacingX * (round + 1);
          final double nextY1 = spacingY * (2 * i + 1);
          final double nextY2 = spacingY * (2 * i + 3);
          final double nextX2 = spacingX * (round + 1);

          canvas.drawLine(Offset(x, y), Offset(nextX1, nextY1), linePaint);
          canvas.drawLine(Offset(x, y), Offset(nextX2, nextY2), linePaint);
          canvas.drawLine(Offset(x, y), Offset(nextX2, nextY2), linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

List<List<String>> generateCompetitionDraw(List<String> participants) {
  List<List<String>> rounds = [];
  List<String> currentRound = participants;

  while (currentRound.length > 1) {
    rounds.add(currentRound);
    List<String> nextRound = [];
    for (int i = 0; i < currentRound.length; i += 2) {
      nextRound.add('Winner of ${currentRound[i]} vs ${currentRound[i + 1]}');
    }
    currentRound = nextRound;
  }
  rounds.add(currentRound);

  return rounds;
}
