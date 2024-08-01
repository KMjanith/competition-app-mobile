import 'dart:async';
import 'package:competition_app/Constants/KarateEvents.dart';
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
  Color blinkingColorLeft = Colors.transparent;
  Color blinkingColorRight = Colors.transparent;

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

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutes == 0 && _seconds == 0) {
          timer.cancel();
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
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      _seconds = widget.seconds;
      _minutes = widget.minutes;
    });
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
                  playerName: widget.akaPlayerName,
                  side: KarateConst.AKA,
                ),
                ScoreBoardComp(
                  playerName: widget.awoPlayerName,
                  side: KarateConst.AWO,
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            right: 250,
            left: 250,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(132, 0, 0, 0),
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
                        onPressed: startTimer,
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: stopTimer,
                        child: const Icon(
                          Icons.stop,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: resetTimer,
                        child: const Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 310,
            right: 310,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(157, 213, 236, 6),
              onPressed: savingScoreBoardDetails,
              child: Text(
                "Save Match",
                style: GoogleFonts.robotoSerif(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          // Blinking color aka
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 80,
              height: double.infinity,
              color: blinkingColorLeft,
            ),
          ),
          // Blinking color awo
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 80,
              height: double.infinity,
              color: blinkingColorRight,
            ),
          ),
        ],
      ),
    );
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
  if (akaPoints > awoPoints) {
    currentState.scoreboardDetails.winner = KarateConst.AKA; // set the winner
    startBlinking(const Color.fromARGB(255, 255, 0, 0), true); // Blink left bar
  } else if (akaPoints < awoPoints) {
    currentState.scoreboardDetails.winner = KarateConst.AWO; // set the winner
    startBlinking(const Color.fromARGB(255, 36, 0, 199), false); // Blink right bar
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
            currentState.scoreboardDetails.winner = currentState.scoreboardDetails.firstPoint;
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
            blinkingColorLeft = blinkingColorLeft == Colors.transparent ? color : Colors.transparent;
          } else {
            blinkingColorRight = blinkingColorRight == Colors.transparent ? color : Colors.transparent;
          }
        });
      }
    });
  }
}
