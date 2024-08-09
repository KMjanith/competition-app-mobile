import 'dart:developer';

import 'package:competition_app/components/competition/linearts/BottomLine.dart';
import 'package:competition_app/components/competition/linearts/StraightLineUpper.dart';
import 'package:competition_app/components/competition/linearts/StraignlineLower.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../components/Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/competition/linearts/UpperLine.dart';

class DrawMaker extends StatefulWidget {
  const DrawMaker({super.key});

  @override
  State<DrawMaker> createState() => _DrawMakerState();
}

class _DrawMakerState extends State<DrawMaker> {
  final List<String> players = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",

  ];

  @override
  Widget build(BuildContext context) {
    List<(String, dynamic)> pairs = getPairs(players);
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const HeadingAnimation(heading: "Draw maker"),
              for (var player in pairs)
                SizedBox(
                  height: 25,
                  width: 80,
                  child: CustomPaint(
                    painter: player.$2,
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8),
                        child: Text(
                          player.$1,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<(String, dynamic)> getPairs(List<String> players) {
    Map<int, dynamic> drawPattern = {
      1: StraightLineUpper(),
      2: UpperLine(),
      3: BottomLine(),
      4: StraightLineLower()
    };
    List<(String, dynamic)> pairs = [];
    int noOfPlayers = players.length;
    int nearMaxValue = 1;
    while (nearMaxValue < noOfPlayers) {
      nearMaxValue <<= 1;
    }

    int byValue = nearMaxValue - noOfPlayers;
    int upper = 0;
    int lower = 0;

    log("No of players: $noOfPlayers, Lowest Value: $nearMaxValue, By Value: $byValue");

    if ((byValue % 2) == 0) {
      // Even case

      upper = byValue ~/ 2; // Return the integer part of the result
      lower = upper;
    } else {
      upper = byValue ~/ 2;
      lower = (byValue ~/ 2) + 1;
    }

    log("Upper: $upper, Lower: $lower");

    // Use lower in pairing logic
    for (int i = 0; i < players.length; i++) {
      if (i < upper) {
        if (i % 2 == 0) {
          pairs.add((players[i], drawPattern[4]));
          continue;
        } else {
          pairs.add((players[i], drawPattern[1]));
          continue;
        }
      } else if (i < players.length - lower) {
        if (i % 2 == 0) {
          pairs.add((players[i], drawPattern[3]));
          continue;
        } else {
          pairs.add((players[i], drawPattern[2]));
          continue;
        }
      } else {
        if (i % 2 == 0) {
          pairs.add((players[i], drawPattern[4]));
          continue;
        } else {
          pairs.add((players[i], drawPattern[1]));
          continue;
        }
      }
    }

    return pairs;
  }
}
