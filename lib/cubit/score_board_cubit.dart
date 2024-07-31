import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../Constants/KarateEvents.dart';
import '../model/ScoreBoard.dart';

part 'score_board_state.dart';

class ScoreBoardCubit extends Cubit<ScoreBoardState> {
  ScoreBoardCubit() : super(ScoreBoardInitial());

  void loadScoreBoard() {
    final scoreBoard = ScoreboardDetails(
        akaPlayerName: '',
        awoPLayerName: '',
        timeDuration: "",
        akaPlayerPoints: [],
        awoPlayerPoints: [],
        winner: KarateConst.AKA,
        akaPenalties: [],
        awoPenalties: [],
        firstPoint: "");
    emit(ScoreBoardLoaded([], scoreBoard));
  }

  void addScoreBoard(ScoreboardDetails scoreBoard) {    /*add new Score Board */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreboardDetails;
      emit(ScoreBoardLoaded(
          [...currentState.scoreBoards, currentRound], currentRound));
    }
  }

  void setNamesAndTime(String akaName, String awoName, String time){    /*set Name and the time */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreboardDetails;
      currentRound.akaPlayerName = akaName;
      currentRound.awoPLayerName = awoName;
      currentRound.timeDuration = time;
      emit(ScoreBoardLoaded(
          currentState.scoreBoards, currentRound));
    }
  }

  void setFirstPoint(String side,bool firstScore) {    /*set first point */
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      final currentRound = currentState.scoreboardDetails;
      if(firstScore){
        currentRound.firstPoint = side;
      }
      else{
        currentRound.firstPoint = "";
      }
      emit(ScoreBoardLoaded(
          currentState.scoreBoards, currentRound));
    }
  }



  void addPoints(int points, String side) {   /*add Points */
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

  void addPenalties(String side) {        /*add penalties */
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

  void popPenalties(String side) {          /*pop penalties */
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

  void popScores(String side) {            /*pop scores */
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
  
  List<int> removePoints(List<int> points) {        /*remove points */
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


}
