import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/model/ScoreBoard.dart';
import 'package:competition_app/services/AuthService.dart';

class ScoreBoardServices {
  void storeScoreBoardDetails(
      FirebaseFirestore db, ScoreboardDetails scoreBoardDetails) async {
    // store the score board details
    final auth = Authservice();
    try {
      final newScoreBoard = <String, dynamic>{
        "userID": auth.getCurrentUserId(),
        "date": DateTime.now().toString().split("at")[0].split(" ")[0],
        "akaPlayerName": scoreBoardDetails.akaPlayerName,
        "awoPLayerName": scoreBoardDetails.awoPLayerName,
        "timeDuration": scoreBoardDetails.timeDuration,
        "akaPlayerPoints": scoreBoardDetails.akaPlayerPoints,
        "awoPlayerPoints": scoreBoardDetails.awoPlayerPoints,
        "winner": scoreBoardDetails.winner,
        "akaPenalties": scoreBoardDetails.akaPenalties,
        "awoPenalties": scoreBoardDetails.awoPenalties,
        "firstPoint": scoreBoardDetails.firstPoint
      };

      db.collection('score_board').add(newScoreBoard);
    } catch (e) {
      throw Exception("Error in storing the score board details");
    }
  }
}
