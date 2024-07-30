import 'dart:async';
import 'package:competition_app/Constants/KarateEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/competition/scoreboard.dart';
import 'package:audioplayers/audioplayers.dart';

class ScoreBoard extends StatefulWidget {
  final String akaPlayerName;
  final String awoPlayerName;
  final int minutes;
  final int seconds;
  const ScoreBoard(
      {super.key,
      required this.akaPlayerName,
      required this.awoPlayerName,
      required this.minutes,
      required this.seconds});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  Timer? timer;
  int? _minutes;
  int? _seconds;
  AudioPlayer? audioPlayer;
  ScoreBoardComp? akaScoreBoard;
  ScoreBoardComp? awoScoreBoard;

  @override
  void initState() {
    super.initState();
    // Set orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _minutes = widget.minutes;
    _seconds = widget.seconds;
    audioPlayer = AudioPlayer();
    akaScoreBoard = ScoreBoardComp(
      /*aka score board */
      color: const Color.fromARGB(255, 187, 16, 3),
      playerName: widget.akaPlayerName,
      side: KarateConst.AKA,
    );
    awoScoreBoard = ScoreBoardComp(
      //awo score board
      color: Color.fromARGB(255, 0, 3, 146),
      playerName: widget.awoPlayerName,
      side: KarateConst.AWO,
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
        } else if (_seconds == 0) {
          _minutes = (_minutes! - 1);
          _seconds = 59;
        } else {
          _seconds = _seconds! - 1;
        }

        // Play beep sound in the last 3 seconds
        if (_minutes == 0 &&
            _seconds != null &&
            _seconds! == 15 &&
            _seconds! > 0) {
          audioPlayer?.play(AssetSource('audios/beep.mp3'));
        }

        if (_minutes == 0 &&
            _seconds != null &&
            _seconds! == 0 &&
            _seconds! >= 0) {
          audioPlayer?.play(AssetSource('audios/ending.mp3'));

          findTheWinner();
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

   void findTheWinner() {
    
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
                akaScoreBoard!,
                awoScoreBoard!,
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
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      TextButton(
                        onPressed: stopTimer,
                        child: const Icon(
                          Icons.stop,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      TextButton(
                        onPressed: resetTimer,
                        child: const Icon(
                          Icons.replay,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 50,
          //   left: 380,
          //   right: 380,
          //     child: FloatingActionButton(
          //       backgroundColor: Color.fromARGB(171, 153, 253, 150),
          //   onPressed: () {},
          //   child: const Text("save match"),
          // ))
        ],
      ),
    );
  }
  
 
}
