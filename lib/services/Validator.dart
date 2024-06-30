import 'package:competition_app/Constants/PaymentStatus.dart';
import 'package:competition_app/model/AddStudentModel.dart';
import 'package:competition_app/model/GradingStudentDetals.dart';

class Validator {
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

  static dynamic gradingStudentValidator(Gradingstudentdetails student) {
    if (student.sNo.isEmpty) {
      return "Please enter S.No";
    } else if (student.currentKyu.isEmpty) {
      return "Please enter Current kyu";
    } else if (student.fullName.isEmpty) {
      return "Please Enter Full Name";
    } else {
      return true;
    }
  }

  static dynamic gradingStudentPaymentDetailsValidator(
      Gradingstudentdetails student) {
    if (student.paymentStatus == PaymentStatus.pending &&
        student.gradingFees.isEmpty &&
        student.paidDate.isEmpty) {
      return true;
    } else if (student.gradingFees.isEmpty) {
      return "Please enter Grading Fees";
    } else if (student.paidDate.isEmpty) {
      return "Please enter Paid Date";
    } else if (student.paymentStatus.isEmpty) {
      return "Please enter Payment Description";
    } else {
      return true;
    }
  }
}
