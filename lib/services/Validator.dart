import 'package:competition_app/model/AddStudentModel.dart';

class Validator{

  static dynamic StudentValidator(Addstudentmodel student) {
    if (student.firstName.isEmpty) {
      return "First Name is empty";
    } else if (student.lastName.isEmpty) {
      return "Last Name is empty";
    } else if (student.nameWithInitials.isEmpty) {
      return "Name with Initials is empty";
    } else if (student.indexNo.isEmpty) {
      return "Index Number is empty";
    } else if (student.shoolGrade.isEmpty) {
      return "School Grade is empty";
    } else if (student.birthDay.isEmpty) {
      return "Birth Day is empty";
    } else if (student.guardianName.isEmpty) {
      return "Guardian Name is empty";
    } else if (student.enteredYear.isEmpty) {
      return "Entered Year is empty";
    } else if (student.homeAddress.isEmpty) {
      return "Home Address is empty";
    } else if (student.mobileNumber.isEmpty) {
      return "Mobile Number is empty";
    } else {
      return true;
    }
  }
}