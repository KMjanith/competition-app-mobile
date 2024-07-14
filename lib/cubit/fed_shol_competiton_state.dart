part of 'fed_shol_competiton_cubit.dart';

@immutable
sealed class FedSholCompetitionState {}

final class FedSholCompetitionInitial extends FedSholCompetitionState {}

final class FedSholCompetitonLoading extends FedSholCompetitionState {}

final class FedSholCompetitonLoaded extends FedSholCompetitionState {
  final List<Competition> competitions;
  final List<Player> lv1KataPlayers ;
  final List<Player> lv2KataPlayers ;
  final List<Player> lv3KataPlayers ;
  final List<Player> lv4KataPlayers ;
  final List<Player> lv5KataPlayers ;

  FedSholCompetitonLoaded(this.competitions, this.lv1KataPlayers, this.lv2KataPlayers, this.lv3KataPlayers, this.lv4KataPlayers, this.lv5KataPlayers);
}

final class FedSholCompetitonError extends FedSholCompetitionState {
  final String message;
  FedSholCompetitonError(this.message);
}
