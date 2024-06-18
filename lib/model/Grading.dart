import 'GradingStudentDetals.dart';

class Grading {
  final String id;
  final String gradingTime;
  final String gradingPlace;
  final List<Gradingstudentdetails> gradingStudentDetails;

  Grading(
      {required this.id,
      required this.gradingTime,
      required this.gradingPlace,
      required this.gradingStudentDetails});
}
