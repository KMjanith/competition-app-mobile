import 'dart:async';

import 'package:flutter/material.dart';

class BlinkContainerExample extends StatefulWidget {
  @override
  _BlinkContainerExampleState createState() => _BlinkContainerExampleState();
}

class _BlinkContainerExampleState extends State<BlinkContainerExample> {
  Color _containerColor = Colors.blue;
  Timer? _timer;
  bool _isBlinking = false;

  void _startBlinking() {
    if (_isBlinking) return;

    _isBlinking = true;
    int blinkCount = 0;
    const maxBlinks = 5 * 2; // Blink for 5 seconds (2 blinks per second)

    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _containerColor = _containerColor == Colors.blue ? Colors.red : Colors.blue;
      });

      blinkCount++;
      if (blinkCount >= maxBlinks) {
        timer.cancel();
        _isBlinking = false;
        setState(() {
          _containerColor = Colors.blue;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blinking Container Example'),
      ),
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: 100,
          height: 100,
          color: _containerColor,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startBlinking,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}