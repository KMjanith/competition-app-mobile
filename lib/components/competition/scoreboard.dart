import 'package:competition_app/Constants/KarateEvents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreBoardComp extends StatefulWidget {
  final Color color;
  final String playerName;
  final String side;
  const ScoreBoardComp({
    super.key,
    required this.color,
    required this.playerName,
    required this.side,
  });

  @override
  State<ScoreBoardComp> createState() => _ScoreBoardCompState();
}

class _ScoreBoardCompState extends State<ScoreBoardComp> {
  int index = 0;
  int score = 0;
  bool akaFirstScore = false;
  bool awoFirstScore = false;
  final List<bool> penalties = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(color: widget.color),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.side,
                  style: GoogleFonts.sancreek(
                    height: 0,
                    color: Color.fromARGB(255, 220, 231, 63),
                    fontSize: 35,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        score = 0;
                        index = 0;
                        penalties.fillRange(0, penalties.length, false);
                        akaFirstScore = false;
                        awoFirstScore = false;
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.restore_outlined, color: Colors.white,),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.playerName,
                  style: GoogleFonts.aDLaMDisplay(
                    height: 0,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 45,
                  ),
                ),
              ],
            ),
            if (widget.side == KarateConst.AKA)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textButton(),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 70.0),
                        child: Text(
                          "$score",
                          style: GoogleFonts.robotoMono(
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontWeight: FontWeight.bold,
                            fontSize: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 45,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: akaFirstScore
                                      ? Color.fromARGB(255, 240, 182, 255)
                                      : Color.fromARGB(0, 243, 194, 255),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      akaFirstScore = !akaFirstScore;
                                    });
                                  },
                                  child: const Icon(
                                      Icons.wb_incandescent_outlined, color: Colors.white,))),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                              height: 45,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(209, 162, 245, 115),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (index < penalties.length) {
                                        penalties[index] = true;
                                        index++;
                                      }
                                    });
                                  },
                                  child: const Text("Penalty"))),
                        ],
                      ),
                      const SizedBox(
                        width: 170,
                      ),
                    ],
                  ),
                ],
              ),
            if (widget.side == KarateConst.AWO)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Text(
                          "$score",
                          style: GoogleFonts.robotoMono(
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontWeight: FontWeight.bold,
                            fontSize: 80,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      textButton()
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 170,
                      ),
                      Row(
                        children: [
                          Container(
                              height: 45,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(209, 162, 245, 115),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      if (index < penalties.length) {
                                        penalties[index] = true;
                                        index++;
                                      }
                                    });
                                  },
                                  child: const Text("Penalty"))),
                          const SizedBox(
                            width: 25,
                          ),
                          Container(
                              height: 45,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: awoFirstScore
                                      ? Color.fromARGB(255, 240, 182, 255)
                                      : Color.fromARGB(0, 243, 194, 255),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      awoFirstScore = !awoFirstScore;
                                    });
                                  },
                                  child: const Icon(
                                      Icons.wb_incandescent_outlined, color: Colors.white,))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(penalties.length, (i) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: penalties[i]
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(75, 255, 255, 255),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container textButton() {
    return Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: const Color.fromARGB(132, 255, 255, 255),
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
            onPressed: () {
              setState(() {
                score++;
              });
            },
            child: const Center(
                child: Icon(
                weight: 51,
              Icons.add,
              size: 18,
            ))));
  }
}
