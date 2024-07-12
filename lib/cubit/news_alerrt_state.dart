part of 'news_alerrt_cubit.dart';

@immutable
sealed class NewsAlertState {}

final class NewsAlertInitial extends NewsAlertState {}

final class NewsAlertLoading extends NewsAlertState {}

final class NewsAlertLoaded extends NewsAlertState {
  final List<Article> articles;
  NewsAlertLoaded(this.articles);
}

final class NewsAlertError extends NewsAlertState {
  final String message;
  NewsAlertError(this.message);
}
