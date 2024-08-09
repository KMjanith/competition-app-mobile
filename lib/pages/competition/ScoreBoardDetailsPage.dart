import 'package:competition_app/components/Constants/KarateEvents.dart';
import 'package:competition_app/model/ScoreBoard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';

class ScoreBoardDetailsPage extends StatelessWidget {
  final ScoreboardDetails scoreboardDetails;
  const ScoreBoardDetailsPage({super.key, required this.scoreboardDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const HeadingAnimation(heading: "Fight Details"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Column(children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(106, 235, 235, 235),
                                    width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  textingDetails("First Point",
                                      scoreboardDetails.firstPoint),
                                  textingDetails("Time Duration",
                                      scoreboardDetails.timeDuration),
                                  textingDetails(
                                      "Winner", scoreboardDetails.winner),
                                  textingDetails(
                                      "Date", scoreboardDetails.date),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("AKA",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: const Color.fromARGB(255, 243, 161, 161),
                              )),
                          scoresAndPenalties(
                              const Color.fromARGB(255, 187, 16, 3),
                              KarateConst.AKA),
                          /*aka */

                          const SizedBox(height: 10),
                          Text("AWO",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: const Color.fromARGB(255, 92, 234, 253),
                              )),
                          scoresAndPenalties(
                              const Color.fromARGB(255, 0, 3, 146),
                              KarateConst.AWO) /*awo */
                        ])),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container scoresAndPenalties(Color color, String side) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (side == KarateConst.AKA)
              Column(
                children: [
                  textingDetails(
                      "AKA Player Name", scoreboardDetails.akaPlayerName),
                  textingDetails("AKA Player Points",
                      scoreboardDetails.akaPlayerPoints.toString()),
                  textingDetails("AKA Penalties",
                      "${scoreboardDetails.akaPenalties.length} penalties")
                ],
              ),
            if (side == KarateConst.AWO)
              Column(
                children: [
                  textingDetails(
                      "AWO Player Name", scoreboardDetails.awoPLayerName),
                  textingDetails("AWO Player Points",
                      scoreboardDetails.awoPlayerPoints.toString()),
                  textingDetails("AWO Penalties",
                      "${scoreboardDetails.awoPenalties.length} penalties")
                ],
              ),
          ],
        ),
      ),
    );
  }

  Padding textingDetails(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              key,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: const Color.fromARGB(255, 235, 235, 235),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              textAlign: TextAlign.left,
              ": $value",
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: const Color.fromARGB(255, 231, 231, 231),
              ),
             
            ),
          ),
        ],
      ),
    );
  }
}
