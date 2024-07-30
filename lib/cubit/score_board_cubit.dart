import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../model/ScoreBoard.dart';


part 'score_board_state.dart';

class ScoreBoardCubit extends Cubit<ScoreBoardState> {
  ScoreBoardCubit() : super(ScoreBoardInitial());

  void loadScoreBoard() {
    emit(ScoreBoardLoaded([]));
  }

  void addScoreBoard(Scoreboard scoreBoard) {
    final currentState = state;
    if (currentState is ScoreBoardLoaded) {
      emit(ScoreBoardLoaded([...currentState.scoreBoards, scoreBoard]));
    }
  }
}
