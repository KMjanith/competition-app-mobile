import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/Grading.dart';
import '../../model/GradingStudentDetals.dart';
import 'db_cubit.dart';

part 'recentgradings_state.dart';

class RecentgradingsCubit extends Cubit<RecentgradingsCubitState> {
  RecentgradingsCubit() : super(RecentgradingsInitial());

  void loadData(BuildContext context) async {
    emit(RecentgradingsLoading());
    var db = BlocProvider.of<DbCubit>(context).firestore;

    try {
      QuerySnapshot querySnapshot = await db.collection('Gradings').get();
      List<Grading> gradings = [];

      for (var doc in querySnapshot.docs) {
        List<dynamic> stringStudent = doc['students'];
        List<Gradingstudentdetails> gradingStudentDetails = [];
        for (var i = 0; i < stringStudent.length; i++) {
          var studentString = stringStudent[i];
          var student = studentString.split(',');
          var studentDetails = Gradingstudentdetails(
            sNo: student[0].trim(),
            fullName: student[1].trim(),
            currentKyu: student[2].trim(),
            paymentStatus: student[3].trim(),
            gradingFees: student[4].trim(),
            paidDate: student[5].trim(),
            passedKyu: student[6].trim()
          );

          gradingStudentDetails.add(studentDetails);
        }

        var grading = Grading(
          id: doc.id,
          gradingPlace: doc['place'],
          gradingTime: doc['date'],
          gradingStudentDetails: gradingStudentDetails,
        );
        gradings.add(grading);
      }

      emit(RecentgradingsLoaded(gradings));
    } catch (e) {
      emit(RecentgradingsError(e.toString()));
    }
  }

  void resetStudents() {
    emit(RecentgradingsInitial());
  }

  void addGrading(Grading grading, BuildContext context) {
    if (state is RecentgradingsLoaded) {
      final currentState = state as RecentgradingsLoaded;
      emit(RecentgradingsLoaded([...currentState.grading, grading]));
    }
  }
  
  void updateGradingList(Grading grading, String newListId) {
    final updatedList = (state as RecentgradingsLoaded)
        .grading
        .map((e) => e.id == newListId ? grading : e)
        .toList();
    emit(RecentgradingsLoaded(updatedList));
  }

  void deleteItem(int index, List<Grading> currentList, String gradingId,
      BuildContext context) {
    final updatedList = List<Grading>.from(currentList);
    updatedList.removeAt(index);
    emit(RecentgradingsLoaded(updatedList)); // Emit the updated state
  }
}
