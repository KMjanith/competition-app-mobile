part of 'view_data_bloc.dart';

@immutable
abstract class ViewDataState {}

final class ViewDataInitial extends ViewDataState {}

class ViewDataLoading extends ViewDataState {}

class ViewDataLoaded extends ViewDataState {
  final List<Map<String, dynamic>> students;
  ViewDataLoaded(this.students);
}

class ViewDataError extends ViewDataState{
  final String Message;
  ViewDataError(this.Message);

}
