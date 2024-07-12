import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/AppConstants.dart';
import '../components/inputs/DatePickerInput.dart';
import '../components/inputs/DropDownInput.dart';
import '../components/inputs/Inputs.dart';
import '../cubit/fed_shol_competiton_cubit.dart';
import '../model/Competition.dart';
import '../model/Player.dart';

class CompetitionService {
  final auth = Authservice();

  void createNewCompetitionPopUp(BuildContext context, String competitionName) {
    print("in competition create method");
    final TextEditingController meetTimeController = TextEditingController();
    final TextEditingController meetPlaceController = TextEditingController();

    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        meetTimeController.text = picked.toString().split(' ')[0];
      }
    }

    String? selectedType;

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
                      print("saving new competiton");
                      saveCompetition(
                          meetTimeController.text,
                          meetPlaceController.text,
                          selectedType!,
                          context,
                          competitionName);
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
          backgroundColor: Color.fromARGB(255, 232, 233, 233),
          title: const Text("Create New Meet"),
          surfaceTintColor: Color.fromARGB(255, 140, 248, 252),
          content: Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                DatePickerInput(
                  dateController: meetTimeController,
                  selectedDate: _selectDate,
                  lableName: "Date",
                ),
                InputField(
                  labelText: "Meet Place",
                  controller: meetPlaceController,
                  keyboardType: TextInputType.text,
                ),
                DropDownInput(
                  onChanged: (value) {
                    selectedType = value;
                  },
                  title: "Competition Type",
                  itemList: AppConstants.provincesOfSriLanka
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> saveCompetition(String date, String place, String type,
      BuildContext context, String competitionNAme) async {
    try {
      final uid = auth.getCurrentUserId();
      final db = BlocProvider.of<DbCubit>(context).firestore;

      final newCompetition = <String, dynamic>{
        "userId": uid,
        'name': competitionNAme,
        'date': date,
        'place': place,
        "type": type,
        'players': <Player>[], //this is to store the student in the grading
      };

      //database creation
      db
          .collection('Competitions')
          .add(newCompetition)
          .then((DocumentReference doc) {
        final newCompetitions = Competition(
            player: [],
            date: DateTime.parse(date),
            name: competitionNAme,
            place: place,
            type: type,
            userId: uid ?? '');

        BlocProvider.of<FedSholCompetitionCubit>(context)
            .addCompetition(newCompetitions);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("New Competition added successfully"),
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
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}
