import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:flutter/material.dart';
import '../../components/common/HedingAnimation.dart';

class MakeCompetition extends StatelessWidget {
  const MakeCompetition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "Make Competition"),
            ],
          ),
        ),
      ),
    );
  }
}
