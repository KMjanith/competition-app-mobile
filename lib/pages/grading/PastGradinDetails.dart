import 'package:flutter/material.dart';

import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/grading/PastGradingDetailsTile.dart';
import '../../model/Grading.dart';

class PastGradinDetails extends StatefulWidget {
  final Grading grading;
  const PastGradinDetails({super.key, required this.grading});

  @override
  State<PastGradinDetails> createState() => _PastgradindetailsState();
}

class _PastgradindetailsState extends State<PastGradinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "Past Gradings Details"),
              const Text(
                "All student and Grading Details are here",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.grading.gradingStudentDetails.length,
                  itemBuilder: (context, index) {
                    return PastGradingDetailsTile(
                      
                        gradingStudent:
                            widget.grading.gradingStudentDetails[index]);
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
