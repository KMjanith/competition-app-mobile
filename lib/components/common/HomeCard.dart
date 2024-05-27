import 'package:flutter/material.dart';

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
          boxShadow: [
            // Top left shadow
            const BoxShadow(
              color: Color.fromARGB(255, 128, 69, 247),
              offset: Offset(-2, -1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
            // Bottom right shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(3, 3),
              blurRadius: 5,
              spreadRadius: 1,
            ),
            // Additional dark shadow
            BoxShadow(
              color: Color.fromARGB(255, 147, 215, 255).withOpacity(0.2),
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 161, 80, 80),
              Color.fromARGB(255, 83, 0, 0),
              Color.fromARGB(255, 37, 35, 150), // Darker color
            ],
            stops: [0.2, 0.5, 0.9],
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
                style: TextStyle(color: color, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
