part of 'update_grading_students_cubit.dart';

@immutable
sealed class UpdateGradingStudentsState {}

final class UpdateGradingStudentsInitial extends UpdateGradingStudentsState {}

class UpdateGradingLoaded extends UpdateGradingStudentsState {
  final List<Gradingstudentdetails> gradingStudentDetails;

  UpdateGradingLoaded(this.gradingStudentDetails);
} 
