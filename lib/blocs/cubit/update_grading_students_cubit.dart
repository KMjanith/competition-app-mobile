import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../model/GradingStudentDetals.dart';

part 'update_grading_students_state.dart';

class UpdateGradingStudentsCubit extends Cubit<List<Gradingstudentdetails>> {
  UpdateGradingStudentsCubit() : super([]);

  void addInitialStudent(List<Gradingstudentdetails> student) {
    emit(student);
  }

  void addStudents(Gradingstudentdetails grading, BuildContext context) {
    emit([...state, grading]);
  }
}
