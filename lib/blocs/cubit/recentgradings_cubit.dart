import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../model/Grading.dart';
import '../../model/GradingStudentDetals.dart';
import 'db_cubit.dart';

part 'recentgradings_state.dart';

class RecentgradingsCubit extends Cubit<List<Grading>> {
  RecentgradingsCubit() : super([]);

  void loadData(BuildContext context) async {
    var db = BlocProvider.of<DbCubit>(context).firestore;

    QuerySnapshot querySnapshot = await db.collection('Gradings').get();
    if (state.isNotEmpty) {
      print("non empty state");
      emit([...state]);
    } else {
      print("empty state");
      for (var doc in querySnapshot.docs) {
        List<dynamic> stringStudent = doc['students'];
        List<Gradingstudentdetails> gradingStudentDetails = [];
        for (var i = 0; i < stringStudent.length; i++) {
          var studentString = stringStudent[i];
          var student = studentString.split(',');
          var studentDetails = Gradingstudentdetails(
            sNo: student[0],
            FullName: student[1],
            currentKyu: student[2],
          );
          gradingStudentDetails.add(studentDetails);
        }
        var grading = Grading(
          id: doc.id,
          gradingPlace: doc['place'],
          gradingTime: (doc['date']),
          gradingStudentDetails:
              gradingStudentDetails, // Parse the String to DateTime
        );
        emit([...state, grading]);
      }
    }
  }

  void resetStudents() {
    emit([]);
  }

  void addGrading(Grading grading, BuildContext context) {
    emit([...state, grading]);
  }

  void addStudentsToExistingGrading(
      String studentDetails, BuildContext context, Grading grading) {
    grading.gradingStudentDetails.add(Gradingstudentdetails(
      sNo: studentDetails.split(',')[0],
      FullName: studentDetails.split(',')[1],
      currentKyu: studentDetails.split(',')[2],
    ));
    emit([grading]);
  }
}
