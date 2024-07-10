import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:flutter/material.dart';

import '../../../components/common/HedingAnimation.dart';

class SchoolAndFederationForm extends StatelessWidget {
  const SchoolAndFederationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(Icons.menu,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
                const HeadingAnimation(heading: "Create New Meet"),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}
