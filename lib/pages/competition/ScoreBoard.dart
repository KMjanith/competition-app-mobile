import 'dart:async';
import 'package:competition_app/components/Constants/KarateEvents.dart';
import 'package:competition_app/components/inputs/Inputs.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/cubit/score_board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import '../../components/competition/scoreboard.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../services/ScoreBoardServices.dart';

class ScoreBoard extends StatefulWidget {
  final String akaPlayerName;
  final String awoPlayerName;
  final int minutes;
  final int seconds;

  const ScoreBoard({
    super.key,
    required this.akaPlayerName,
    required this.awoPlayerName,
    required this.minutes,
    required this.seconds,
  });

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  Timer? timer;
  int? _minutes;
  int? _seconds;
  AudioPlayer? audioPlayer;
  Color blinkingColorLeft = Color.fromARGB(0, 226, 154, 154);
  Color blinkingColorRight = Color.fromARGB(0, 163, 169, 240);
  Color timerColor = const Color.fromARGB(132, 0, 0, 0);
  var flag = false;

  @override
  void initState() {
    super.initState();
    // Set orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _minutes = widget.minutes;
    _seconds = widget.seconds;
    audioPlayer = AudioPlayer();

    BlocProvider.of<ScoreBoardCubit>(context).setNamesAndTime(
      widget.akaPlayerName,
      widget.awoPlayerName,
      "${widget.minutes}:${widget.seconds}",
    );
  }

  @override
  void dispose() {
    // Revert to the default orientation when leaving the page
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    timer?.cancel();
    audioPlayer?.dispose(); // Dispose the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                ScoreBoardComp(
                  playerName: widget.awoPlayerName,
                  side: KarateConst.AWO,
                ),
                ScoreBoardComp(
                  playerName: widget.akaPlayerName,
                  side: KarateConst.AKA,
                ),
              ],
            ),
          ),

          //-------------------------------middle bars-----------------------------------------------------
          Positioned(
            left: 320,
            right: 320,
            bottom: 0,
            top: 0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 50,
                    height: double.infinity,
                    decoration: BoxDecoration(color: blinkingColorLeft),
                    child: Text(""),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: double.infinity,
                    width: 50,
                    decoration: BoxDecoration(color: blinkingColorRight),
                    child: Text(""),
                  ),
                )
              ],
            ),
          ),

          //---------------------------------------------------timer widget----------------------------------------------------------
          Positioned(
            top: 110,
            right: 250,
            left: 250,
            child: Container(
              decoration: BoxDecoration(
                color: timerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    "${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}",
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 65,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: flags,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 147, 148, 143),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.pause,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: resetTimer,
                        child: const Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: changeTime,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 0, 151, 5)),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10),
                            child: Icon(
                              Icons.fiber_new_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //----------------------------upper bars-------------------------------------------------------
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(color: blinkingColorLeft),
                    child: Text(""),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(color: blinkingColorRight),
                    child: Text(""),
                  ),
                )
              ],
            ),
          ),

          //----------------------------------------------------------------------save match button----------------------------------------------
          Positioned(
            top: 20,
            left: 340,
            right: 340,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(220, 213, 236, 6),
              onPressed: savingScoreBoardDetails,
              child: Text(
                "Save ",
                style: GoogleFonts.robotoSerif(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //--------------------------------------------------lower bars-----------------------------------------
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(color: blinkingColorLeft),
                    child: Text(""),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(color: blinkingColorRight),
                    child: Text(""),
                  ),
                )
              ],
            ),
          ),

          // Blinking color awo bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 50,
              height: double.infinity,
              color: blinkingColorLeft,
            ),
          ),

          // Blinking color aka bar
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 50,
              height: double.infinity,
              color: blinkingColorRight,
            ),
          ),
        ],
      ),
    );
  }

  void flags() {
    setState(() {
      flag = !flag;
      if (flag) {
        timerColor = const Color.fromARGB(0, 0, 0, 0);
        startTimer();
      } else {
        timerColor = const Color.fromARGB(132, 0, 0, 0);
        stopTimer();
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutes == 0 && _seconds == 0) {
          flag = !flag;
          timer.cancel();
          timerColor = const Color.fromARGB(0, 0, 0, 0);
          audioPlayer?.play(AssetSource('audios/ending.mp3'));
          saveTheWinner();
        } else if (_seconds == 0) {
          _minutes = (_minutes! - 1);
          _seconds = 59;
        } else {
          _seconds = _seconds! - 1;
        }

        // Play beep sound in the last 3 seconds
        if (_minutes == 0 && _seconds == 15) {
          audioPlayer?.play(AssetSource('audios/beep.mp3'));
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
    timerColor = const Color.fromARGB(132, 0, 0, 0);
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      _seconds = widget.seconds;
      _minutes = widget.minutes;
    });
  }

  void savingScoreBoardDetails() {
    saveTheWinner();
    final db = BlocProvider.of<DbCubit>(context).firestore;
    final scoreBoardService = ScoreBoardServices();
    scoreBoardService.storeScoreBoardDetails(
      db,
      context.read<ScoreBoardCubit>().state.scoreboardDetails,
    );
    BlocProvider.of<ScoreBoardCubit>(context)
        .addScoreBoard(context.read<ScoreBoardCubit>().state.scoreboardDetails);
    QuickAlert.show(
      context: context,
      title: "Match saved",
      type: QuickAlertType.success,
      onConfirmBtnTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  void saveTheWinner() {
    final currentState =
        context.read<ScoreBoardCubit>().state as ScoreBoardLoaded;
    List<int> akaPlayerPoints = currentState.scoreboardDetails.akaPlayerPoints;
    List<int> awoPlayerPoints = currentState.scoreboardDetails.awoPlayerPoints;
    int akaPoints = 0;
    int awoPoints = 0;
    int yuko = 0;
    int wazariaka = 0;
    int ipponaka = 0;
    int yukoawo = 0;
    int wariawo = 0;
    int ipponawo = 0;
    for (int i = 0; i < akaPlayerPoints.length; i++) {
      akaPoints += akaPlayerPoints[i];
    }
    for (int i = 0; i < awoPlayerPoints.length; i++) {
      awoPoints += awoPlayerPoints[i];
    }
    if (awoPoints > akaPoints) {
      currentState.scoreboardDetails.winner = KarateConst.AWO; // set the winner
      startBlinking(Color.fromARGB(255, 127, 228, 241), true);
    } else if (akaPoints > awoPoints) {
      currentState.scoreboardDetails.winner = KarateConst.AKA; // set the winner
      startBlinking(
          const Color.fromARGB(255, 255, 128, 128), false); // Blink left bar
      // Blink right bar
    } else {
      // handle tie scenario
      for (int i = 0; i < akaPlayerPoints.length; i++) {
        if (akaPlayerPoints[i] == 1) {
          yuko++;
        } else if (akaPlayerPoints[i] == 2) {
          wazariaka++;
        } else if (akaPlayerPoints[i] == 3) {
          ipponaka++;
        }
      }
      for (int i = 0; i < awoPlayerPoints.length; i++) {
        if (awoPlayerPoints[i] == 1) {
          yukoawo++;
        } else if (awoPlayerPoints[i] == 2) {
          wariawo++;
        } else if (awoPlayerPoints[i] == 3) {
          ipponawo++;
        }
      }

      if (yuko > yukoawo) {
        currentState.scoreboardDetails.winner = KarateConst.AKA;
        startBlinking(const Color.fromARGB(255, 139, 0, 0), true);
      } else if (yuko < yukoawo) {
        currentState.scoreboardDetails.winner = KarateConst.AWO;
        startBlinking(const Color.fromARGB(255, 9, 0, 138), false);
      } else {
        if (wazariaka > wariawo) {
          currentState.scoreboardDetails.winner = KarateConst.AKA;
          startBlinking(const Color.fromARGB(255, 139, 0, 0), true);
        } else if (wazariaka < wariawo) {
          currentState.scoreboardDetails.winner = KarateConst.AWO;
          startBlinking(const Color.fromARGB(255, 9, 0, 138), false);
        } else {
          if (ipponaka > ipponawo) {
            currentState.scoreboardDetails.winner = KarateConst.AKA;
            startBlinking(const Color.fromARGB(255, 139, 0, 0), true);
          } else if (ipponaka < ipponawo) {
            currentState.scoreboardDetails.winner = KarateConst.AWO;
            startBlinking(const Color.fromARGB(255, 9, 0, 138), false);
          } else {
            currentState.scoreboardDetails.winner =
                currentState.scoreboardDetails.firstPoint;
          }
        }
      }
    }
  }

  void startBlinking(Color color, bool isLeftBar) {
    const blinkDuration = Duration(milliseconds: 300);
    const totalBlinkTime = Duration(seconds: 4);
    final endTime = DateTime.now().add(totalBlinkTime);

    Timer.periodic(blinkDuration, (timer) {
      if (DateTime.now().isAfter(endTime)) {
        timer.cancel();
        setState(() {
          if (isLeftBar) {
            blinkingColorLeft = Colors.transparent;
          } else {
            blinkingColorRight = Colors.transparent;
          }
        });
      } else {
        setState(() {
          if (isLeftBar) {
            blinkingColorLeft = blinkingColorLeft == Colors.transparent
                ? color
                : Colors.transparent;
          } else {
            blinkingColorRight = blinkingColorRight == Colors.transparent
                ? color
                : Colors.transparent;
          }
        });
      }
    });
  }

  void changeTime() {
    final minutesController = TextEditingController();
    final secondsController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 36, 36, 36),
            title: const Text(
              "Change Time",
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              children: [
                InputField(
                  labelText: "minutes",
                  controller: minutesController,
                  keyboardType: TextInputType.number,
                ),
                InputField(
                  labelText: "seconds",
                  controller: secondsController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 21, 243, 95),
                    ),
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        final newMinutes = int.tryParse(minutesController.text);
                        final newSeconds = int.tryParse(secondsController.text);
                        if (newMinutes == null) {
                          setState(() {
                            _minutes = 0;
                            _seconds = newSeconds;
                          });
                        } else {
                          setState(() {
                            _minutes = newMinutes;
                            _seconds = newSeconds;
                          });
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Start",
                        style: TextStyle(color: Color.fromARGB(255, 7, 0, 39)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
