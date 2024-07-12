part of 'past_grading_details_cubit.dart';

@immutable
sealed class PastGradingDetailsState {}

final class PastGradingDetailsInitial extends PastGradingDetailsState {}

final class PastGradingDetailsLoading extends PastGradingDetailsState {}

final class PastGradingDetailsLoaded extends PastGradingDetailsState {
  final List<Gradingstudentdetails> gradingstudentDetails;

  PastGradingDetailsLoaded(this.gradingstudentDetails);
}

final class PastGradingDetailsError extends PastGradingDetailsState {
  final String message;

  PastGradingDetailsError(this.message);
}
