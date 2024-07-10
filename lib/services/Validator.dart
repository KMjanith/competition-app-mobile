import 'package:competition_app/Constants/PaymentStatus.dart';
import 'package:competition_app/model/AddStudentModel.dart';
import 'package:competition_app/model/GradingStudentDetals.dart';
import 'package:intl/intl.dart';

class Validator {
  static dynamic StudentValidator(Addstudentmodel student) {
    // Validate if fields are empty
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
    }

    // Validate firstName, lastName, nameWithInitials, and guardianName contain only letters
    RegExp stringPattern = RegExp(r'^[a-zA-Z]+$');
    if (!stringPattern.hasMatch(student.firstName)) {
      return "First Name must contain only letters";
    } else if (!stringPattern.hasMatch(student.lastName)) {
      return "Last Name must contain only letters";
    } else if (!stringPattern.hasMatch(student.nameWithInitials)) {
      return "Name with Initials must contain only letters";
    } else if (!stringPattern.hasMatch(student.guardianName)) {
      return "Guardian Name must contain only letters";
    }

    // Validate indexNo is a number and has a maximum of 6 digits
    if (!RegExp(r'^\d{1,6}$').hasMatch(student.indexNo)) {
      return "Index Number must be a number with a maximum of 6 digits";
    }

    // Validate birthday is at least 5 years from now
    DateTime birthDate;
    try {
      birthDate = DateFormat('yyyy-MM-dd').parse(student.birthDay);
    } catch (e) {
      return "Birth Day format is incorrect. Expected format: yyyy-MM-dd";
    }
    DateTime currentDate = DateTime.now();
    DateTime fiveYearsAgo = DateTime(currentDate.year - 5, currentDate.month);
    if (birthDate.isAfter(fiveYearsAgo)) {
      return "Birth Day must be at least 5 years ago";
    }

    // Validate enteredYear is at least 2 years back from now
    int enteredYear;
    try {
      enteredYear = int.parse(student.enteredYear);
    } catch (e) {
      return "Entered Year format is incorrect. Expected format: yyyy";
    }
    int currentYear = currentDate.year;
    if (enteredYear > currentYear - 2) {
      return "Entered Year must be at least 2 years ago";
    }

    // Validate mobileNumber contains exactly 10 digits
    if (!RegExp(r'^\d{10}$').hasMatch(student.mobileNumber)) {
      return "Mobile Number must contain exactly 10 digits";
    }

    // If all validations pass
    return true;
  }

  static dynamic gradingStudentValidator(Gradingstudentdetails student) {
    // Validate if fields are empty
    if (student.sNo.isEmpty) {
      return "Please enter S.No";
    } else if (student.currentKyu.isEmpty) {
      return "Please enter Current kyu";
    } else if (student.fullName.isEmpty) {
      return "Please Enter Full Name";
    }

    // Validate currentKyu is between 1 and 9
    int currentKyu;
    try {
      currentKyu = int.parse(student.currentKyu);
    } catch (e) {
      return "Current kyu must be a number between 1 and 9";
    }
    if (currentKyu < 1 || currentKyu > 9) {
      return "Current kyu must be between 1 and 9";
    }

    // Validate fullName contains only letters
    RegExp stringPattern = RegExp(r'^[a-zA-Z\s]+$');
    if (!stringPattern.hasMatch(student.fullName)) {
      return "Full Name must contain only letters";
    }

    // If all validations pass
    return true;
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
