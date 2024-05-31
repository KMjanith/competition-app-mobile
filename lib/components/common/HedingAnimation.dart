import "package:animated_text_kit/animated_text_kit.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class HeadingAnimation extends StatefulWidget {
  final String heading;
  const HeadingAnimation({super.key, required this.heading});

  @override
  State<HeadingAnimation> createState() => _HeadingAnimationState();
}

class _HeadingAnimationState extends State<HeadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20, bottom: 20),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            "${widget.heading}...",
            textStyle: GoogleFonts.cairo(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Color.fromARGB(255, 0, 69, 87),
            ),
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 1,
        pause: const Duration(milliseconds: 1000),
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
      ),
    );
  }
}
