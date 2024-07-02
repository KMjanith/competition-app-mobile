part of 'recentgradings_cubit.dart';

@immutable
sealed class RecentgradingsCubitState {}

class RecentgradingsInitial extends RecentgradingsCubitState {}

class RecentgradingsLoading extends RecentgradingsCubitState {}

class RecentgradingsLoaded extends RecentgradingsCubitState {
  final List<Grading> grading;

  RecentgradingsLoaded(this.grading);
}

class RecentgradingsError extends RecentgradingsCubitState {
  final String message;

  RecentgradingsError(this.message);
}