part of 'score_board_cubit.dart';

@immutable
sealed class ScoreBoardState {}

final class ScoreBoardInitial extends ScoreBoardState {}

final class ScoreBoardLoaded extends ScoreBoardState {
  final List<Scoreboard> scoreBoards;

  ScoreBoardLoaded(this.scoreBoards);
}
