import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String buttonText;
  final Widget targetPage;

  const HomeCard({
    Key? key,
    required this.buttonText,
    required this.targetPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          child: Text(buttonText),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => targetPage,
              ),
            );
          },
        ),
      ),
    );
  }
}
