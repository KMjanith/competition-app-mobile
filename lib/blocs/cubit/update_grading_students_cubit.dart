import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../model/GradingStudentDetals.dart';

part 'update_grading_students_state.dart';

class UpdateGradingStudentsCubit extends Cubit<List<Gradingstudentdetails>> {
  UpdateGradingStudentsCubit() : super([]);

  void addInitialStudent(List<Gradingstudentdetails> student) {
    emit(student);
  }

  void addStudents(Gradingstudentdetails studentDetails, BuildContext context) {
    final currentList =  List<Gradingstudentdetails>.from(state);
    currentList.add(studentDetails);
    emit(currentList);
  }


  void updateStudents(List<Gradingstudentdetails> newList) {
    print("in the delete student method");
    emit([...newList]);
  }
}
