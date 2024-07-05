import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/Grading.dart';
import '../../../model/GradingStudentDetals.dart';

abstract class GradingDatabaseService {
  void createNewGradingPopUp(BuildContext context);
  void createNewGrading(String date, String place, BuildContext context);
  void addStudent(
      Gradingstudentdetails student, BuildContext context, Grading grading);
  Future<void> addStudentsToGradings(
      String docId, List<String> newStudent, BuildContext context);
  Future<void> updateGradingStudentDetails(String gradingId,
      List<Gradingstudentdetails> newDetails, BuildContext context, String successMessage, String errorMessage);
  Future<void> deleteGrading(String gradingId, BuildContext context);
  Future<String> deleteStudentFromGrading(
      String gradingId,
      FirebaseFirestore db,
      List<Gradingstudentdetails> currentList,
      Gradingstudentdetails deletedStudent,BuildContext context);
}
