part of 'score_board_cubit.dart';

@immutable
sealed class ScoreBoardState {
  get scoreboardDetails => null;
}

final class ScoreBoardInitial extends ScoreBoardState {}

final class ScoreBoardLoading extends ScoreBoardState {}

final class ScoreBoardLoaded extends ScoreBoardState {
  final List<ScoreboardDetails> scoreBoards;
  final ScoreboardDetails scoreboardDetails;

  ScoreBoardLoaded(this.scoreBoards, this.scoreboardDetails);
}
