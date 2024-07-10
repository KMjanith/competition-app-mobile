part of 'view_data_cubit.dart';

@immutable
sealed class ViewStudentDataState {}

final class ViewDataStudentsInitial extends ViewStudentDataState {}

final class ViewDataStudentsLoading extends ViewStudentDataState {}

final class ViewDataStudentsLoaded extends ViewStudentDataState {
  final List<Map<String, dynamic>> students;
  ViewDataStudentsLoaded(this.students);
}

final class ViewDataStudentsError extends ViewStudentDataState {
  final String message;
  ViewDataStudentsError(this.message);
}
