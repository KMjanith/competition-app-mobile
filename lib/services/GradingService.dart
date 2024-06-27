import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/Constants/PaymentStatus.dart';
import 'package:competition_app/model/Grading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/cubit/db_cubit.dart';
import '../blocs/cubit/recentgradings_cubit.dart';
import '../blocs/cubit/update_grading_students_cubit.dart';
import '../components/inputs/DatePickerInput.dart';
import '../components/inputs/Inputs.dart';
import '../model/GradingStudentDetals.dart';
import 'Validator.dart';

class Gradingservice {
  void createNewGradingPopUp(BuildContext context) {
    final TextEditingController gradingTimeController = TextEditingController();
    final TextEditingController gradingPlaceController =
        TextEditingController();

    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        gradingTimeController.text = picked.toString().split(' ')[0];
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 21, 243, 95),
                  ),
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      final dateString = gradingTimeController.text;
                      if (dateString.isNotEmpty) {
                        createNewGrading(
                            dateString, gradingPlaceController.text, context);
                      }
                    },
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Color.fromARGB(255, 7, 0, 39)),
                    ),
                  ),
                ),
              ],
            ),
          ],
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Text("Create New Grading"),
          content: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                DatePickerInput(
                  dateController: gradingTimeController,
                  selectedDate: _selectDate,
                  lableName: "Date",
                ),
                InputField(
                  labelText: "Grading Place",
                  controller: gradingPlaceController,
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //create a new document in grading collection
  void createNewGrading(String date, String place, BuildContext context) {
    final db = BlocProvider.of<DbCubit>(context).firestore;
    final stating = BlocProvider.of<RecentgradingsCubit>(context).state;
    final newGrading = <String, dynamic>{
      'id': (stating.length + 1),
      'date': date,
      'place': place,
      'students':
          <Gradingstudentdetails>[], //this is to store the student in the grading
    };

    final _newGrading = Grading(
      id: (stating.length + 1).toString(),
      gradingTime: date,
      gradingPlace: place,
      gradingStudentDetails: [],
    );
    BlocProvider.of<RecentgradingsCubit>(context)
        .addGrading(_newGrading, context); //this is to update the UI

    //database updation
    db.collection('Gradings').add(newGrading).then((DocumentReference doc) {
      print("new Grading snapshot added with ID: ${doc.id}");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("New Grading added successfully"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      print("Failed to add new Grading: $error");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to add new Grading: $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }

  void addStudent(
      BuildContext context,
      String sNoController,
      String studentNameController,
      String currentKyuCOntroller,
      Grading grading) {
    final student = Gradingstudentdetails(
        sNo: sNoController,
        fullName: studentNameController,
        currentKyu: currentKyuCOntroller,
        paymentStatus: PaymentStatus.pending,
        gradingFees: '',
        paidDate: '',
        paymentDescription: '');

    //form validator
    final allset = Validator.gradingStudentValidator(student);

    if (allset == true) {
      //updating the ui
      BlocProvider.of<UpdateGradingStudentsCubit>(context)
          .addStudents(student, context);
      BlocProvider.of<RecentgradingsCubit>(context).addStudentsToExistingGrading(
          '$sNoController, $studentNameController, $currentKyuCOntroller, ${student.paymentStatus}',
          context,
          grading);
      addStudentsToGradings(
          grading.id,
          [
            '$sNoController, $studentNameController, $currentKyuCOntroller, ${student.paymentStatus}'
          ],
          context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 165, 5, 2),
          content: Text(
            allset,
            style: GoogleFonts.alegreya(fontSize: 20),
          ),
        ),
      );
    }
  }

  //add students to students array in perticular doc
  Future<void> addStudentsToGradings(
      String docId, List<String> newStudent, BuildContext context) async {
    // Reference to the specific document in the "gradins" collection
    DocumentReference gradinsDocRef =
        FirebaseFirestore.instance.collection('Gradings').doc(docId);

    try {
      // Update the document by adding new students to the array field
      await gradinsDocRef
          .update({'students': FieldValue.arrayUnion(newStudent)});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 8, 95, 0),
        content: Text(
          "Students added successfully!",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error adding students: $e",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
    }
  }

  Future<void> updatePaymentStatus(String gradingId,
      List<Gradingstudentdetails> newDetails, BuildContext context) async {
    final List<String> studentDetails = getStudentDetails(newDetails);

    final db = BlocProvider.of<DbCubit>(context).firestore;
    DocumentReference gradingDocRef = db.collection('Gradings').doc(gradingId);

    try {
      await gradingDocRef.update({'students': studentDetails});
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 0, 124, 0),
        content: Text(
          "Successfully updated payment status:",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error updating payment status: $e",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
    }
  }

  List<String> getStudentDetails(List<Gradingstudentdetails> students) {
    final List<String> studentDetails = [];
    for (var student in students) {
      studentDetails.add(
          '${student.sNo}, ${student.fullName}, ${student.currentKyu}, ${student.paymentStatus}, ${student.gradingFees}, ${student.paidDate}');
    }
    return studentDetails;
  }
}
