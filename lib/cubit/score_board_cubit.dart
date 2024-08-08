import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../components/Constants/KarateEvents.dart';
import '../model/ScoreBoard.dart';
import '../services/AuthService.dart';
part 'score_board_state.dart';

class ScoreBoardCubit extends Cubit<ScoreBoardState> {
  ScoreBoardCubit() : super(ScoreBoardInitial());

  void loadScoreBoard(BuildContext context) async {
    emit(ScoreBoardLoading());
    final db = BlocProvider.of<DbCubit>(context).firestore;

    // Get the current user's UID
    final auth = Authservice();
    final uid = auth.getCurrentUserId();
    QuerySnapshot querySnapshot = await db
        .collection('score_board')
        .where('userID', isEqualTo: uid)
        .get(); //get only the user's grading
    final List<ScoreboardDetails> scoreBoards = [];

    for (var doc in querySnapshot.docs) {
      final scoreBoardDetails = ScoreboardDetails(
          id: doc.id,
          akaPlayerName: doc['akaPlayerName'],
          firstPoint: doc['firstPoint'],
          awoPLayerName: doc['awoPLayerName'],
          timeDuration: doc['timeDuration'],
          akaPlayerPoints: List<int>.from(doc['akaPlayerPoints']),
          awoPlayerPoints: List<int>.from(doc['awoPlayerPoints']),
          winner: doc['winner'],
          akaPenalties: List<int>.from(doc['akaPenalties']),
          awoPenalties: List<int>.from(doc['awoPenalties']),
          date: doc['date']
          );

      scoreBoards.add(scoreBoardDetails);
    }
    final scoreBoard = ScoreboardDetails(
        id: "",
        akaPlayerName: '',
        awoPLayerName: '',
        timeDuration: "",
        akaPlayerPoints: [],
        awoPlayerPoints: [],
        winner: KarateConst.AKA,
        akaPenalties: [],
        awoPenalties: [],
        firstPoint: "",
        date: DateTime.now().toString().split("at")[0].split(" ")[0]
        );
    emit(ScoreBoardLoaded(scoreBoards, scoreBoard));
  }

  void addScoreBoard(ScoreboardDetails scoreBoard) {
    /*add new Score Board */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreboardDetails;
      emit(ScoreBoardLoaded(
          [...currentState.scoreBoards, currentRound], currentRound));
    }
  }

  void setNamesAndTime(String akaName, String awoName, String time) {
    /*set Name and the time */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreboardDetails;
      currentRound.akaPlayerName = akaName;
      currentRound.awoPLayerName = awoName;
      currentRound.timeDuration = time;
      emit(ScoreBoardLoaded(currentState.scoreBoards, currentRound));
    }
  }

  void setFirstPoint(String side, bool firstScore) {
    /*set first point */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreboardDetails;
      if (firstScore) {
        currentRound.firstPoint = side;
      } else {
        currentRound.firstPoint = "";
      }
      emit(ScoreBoardLoaded(currentState.scoreBoards, currentRound));
    }
  }

  void addPoints(int points, String side) {
    /*add Points */
    final currentState = state;
    if (state is ScoreBoardLoaded) {
      currentState as ScoreBoardLoaded;
      if (side == KarateConst.AKA) {
        currentState.scoreboardDetails.akaPlayerPoints.add(points);
        emit(ScoreBoardLoaded(
            currentState.scoreBoards, currentState.scoreboardDetails));
      } else {
        currentState.scoreboardDetails.awoPlayerPoints.add(points);
        emit(ScoreBoardLoaded(
            currentState.scoreBoards, currentState.scoreboardDetails));
      }
    }
  }

  void addPenalties(String side) {
    /*add penalties */
    final currentState = state;
    if (state is ScoreBoardLoaded) {
      currentState as ScoreBoardLoaded;
      if (side == KarateConst.AKA) {
        if (currentState.scoreboardDetails.akaPenalties.length <= 6) {
          currentState.scoreboardDetails.akaPenalties.add(1);
          emit(ScoreBoardLoaded(
              currentState.scoreBoards, currentState.scoreboardDetails));
        }
      } else {
        if (currentState.scoreboardDetails.awoPenalties.length <= 6) {
          currentState.scoreboardDetails.awoPenalties.add(1);
          emit(ScoreBoardLoaded(
              currentState.scoreBoards, currentState.scoreboardDetails));
        }
      }
    }
  }

  void popPenalties(String side) {
    /*pop penalties */
    final currentState = state;
    if (state is ScoreBoardLoaded) {
      currentState as ScoreBoardLoaded;
      if (side == KarateConst.AKA) {
        if (currentState.scoreboardDetails.akaPenalties.isNotEmpty) {
          currentState.scoreboardDetails.akaPenalties.removeLast();
          emit(ScoreBoardLoaded(
              currentState.scoreBoards, currentState.scoreboardDetails));
        }
      } else {
        if (currentState.scoreboardDetails.awoPenalties.isNotEmpty) {
          currentState.scoreboardDetails.awoPenalties.removeLast();
          emit(ScoreBoardLoaded(
              currentState.scoreBoards, currentState.scoreboardDetails));
        }
      }
    }
  }

  void popScores(String side) {
    /*pop scores */
    final currentState = state;
    if (state is ScoreBoardLoaded) {
      currentState as ScoreBoardLoaded;
      if (side == KarateConst.AKA) {
        currentState.scoreboardDetails.akaPlayerPoints =
            removePoints(currentState.scoreboardDetails.akaPlayerPoints);

        emit(ScoreBoardLoaded(
            currentState.scoreBoards, currentState.scoreboardDetails));
      }
      if (side == KarateConst.AWO) {
        currentState.scoreboardDetails.awoPlayerPoints =
            removePoints(currentState.scoreboardDetails.awoPlayerPoints);
        emit(ScoreBoardLoaded(
            currentState.scoreBoards, currentState.scoreboardDetails));
      }
    }
  }

  List<int> removePoints(List<int> points) {
    /*remove points */
    if (points.isEmpty) {
      return points;
    }
    int last = points.last;
    last = last - 1;
    if (last == 0) {
      points.removeLast();
      return points;
    } else {
      points.removeLast();
      points.add(last);
      return points;
    }
  }

  void deleteScoreBoard(int index){
    /*delete score board */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreBoards;
      currentRound.removeAt(index);
      emit(ScoreBoardLoaded(currentRound, currentState.scoreboardDetails));
    }
  }
}
