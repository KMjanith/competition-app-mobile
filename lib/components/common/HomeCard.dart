import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCard extends StatelessWidget {
  final String buttonText;
  final Color color;
  final VoidCallback onPressed;

  const HomeCard({
    Key? key,
    required this.buttonText,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 250,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            // Top left shadow
            BoxShadow(
              color: Color.fromARGB(255, 59, 10, 156),
              offset: Offset(2, 1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 244, 158, 255),
              Color.fromARGB(255, 55, 169, 235),
              Color.fromARGB(255, 15, 164, 190),
              Color.fromARGB(255, 16, 108, 151), // Darker color
            ],
            stops: [0.05, 0.4, 0.5, 0.9],
          ),
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
                    color: Colors.white,
                    size: 20,
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: GoogleFonts.roboto(color: color, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
