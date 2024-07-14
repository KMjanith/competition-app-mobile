import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'view_data_state.dart';

class ViewStudentDataCubit extends Cubit<ViewStudentDataState> {
  ViewStudentDataCubit() : super(ViewDataStudentsInitial());

  void loadStudents(BuildContext context) async {
    final List<Map<String, dynamic>> _students = [];
    emit(ViewDataStudentsLoading());

    try {
      final db = BlocProvider.of<DbCubit>(context).firestore;
      final authSerice = Authservice();
      QuerySnapshot querySnapshot = await db
          .collection('students')
          .where('user', isEqualTo: authSerice.getCurrentUserId())
          .get();

      _students.clear(); // Clear previous data
      for (var doc in querySnapshot.docs) {
        _students.add(doc.data() as Map<String, dynamic>);
      }
      emit(ViewDataStudentsLoaded(_students));
    } catch (e) {
      emit(ViewDataStudentsError('Error loading students'));
    }
  }

  List<Map<String, dynamic>> getStudents() {
    return (state as ViewDataStudentsLoaded).students;
  }

  deleteStudent(String indexNo, BuildContext context,
      List<Map<String, dynamic>> currentStudent, int index) async {
    final db = BlocProvider.of<DbCubit>(context).firestore;
    final authSerice = Authservice();
    try {
      emit(ViewDataDeletingLoading());
      await db
          .collection('students')
          .where('indexNo', isEqualTo: indexNo)
          .where('user', isEqualTo: authSerice.getCurrentUserId())
          .get()
          .then((value) {
        value.docs.first.reference.delete();
      });

      final updatedList = List<Map<String, dynamic>>.from(currentStudent);
      updatedList.removeAt(index);
      emit(ViewDataStudentsLoaded(updatedList)); // Emit the updated state
     
    } catch (e) {
      emit(ViewDataStudentsError('Error deleting student'));
    }
  }
}
