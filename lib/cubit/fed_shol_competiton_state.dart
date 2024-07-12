part of 'fed_shol_competiton_cubit.dart';

@immutable
sealed class FedSholCompetitionState {}

final class FedSholCompetitionInitial extends FedSholCompetitionState {}

final class FedSholCompetitonLoading extends FedSholCompetitionState {}

final class FedSholCompetitonLoaded extends FedSholCompetitionState {
  final List<Competition> competitions;
  FedSholCompetitonLoaded(this.competitions);
}

final class FedSholCompetitonError extends FedSholCompetitionState {
  final String message;
  FedSholCompetitonError(this.message);
}




