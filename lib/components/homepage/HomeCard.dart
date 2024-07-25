import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatefulWidget {
  final String buttonText;
  final Color color;
  final VoidCallback onPressed;
  final String description;

  const HomeCard({
    Key? key,
    required this.buttonText,
    required this.color,
    required this.onPressed,
    required this.description,
  }) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 220,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            // Top left shadow
            BoxShadow(
              color: Color.fromARGB(125, 0, 0, 0),
              offset: Offset(1, 5),
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
          gradient: StyleConstants.homeCardGradient
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Information"),
                            content: const Text(
                                "This is a card to add a new student"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Close"))
                            ],
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 20,
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: widget.onPressed,
              child: Text(
                widget.buttonText,
                style: GoogleFonts.roboto(color: widget.color, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(103, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      textAlign: TextAlign.center,
                      widget.description,
                      textStyle: GoogleFonts.cairo(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 69, 87),
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: Duration.minutesPerDay,
                  pause: const Duration(milliseconds: 5000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
