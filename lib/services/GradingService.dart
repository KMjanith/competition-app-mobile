import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/model/Grading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cubit/db_cubit.dart';
import '../blocs/cubit/recentgradings_cubit.dart';
import '../components/inputs/DatePickerInput.dart';
import '../components/inputs/Inputs.dart';
import '../model/GradingStudentDetals.dart';

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
      'students': <Gradingstudentdetails>[], //this is to store the student in the grading
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
}
