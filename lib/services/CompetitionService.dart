import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:competition_app/services/Validator.dart';
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
    final TextEditingController meetTimeController = TextEditingController();
    final TextEditingController meetPlaceController = TextEditingController();
    final TextEditingController weightController = TextEditingController();

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
                    color: const Color.fromARGB(255, 21, 243, 95),
                  ),
                  width: 100,
                  child: TextButton(
                    onPressed: () {
                      savingValidationCompetiton(
                          meetTimeController.text,
                          meetPlaceController.text,
                          selectedType ?? "",
                          context,
                          weightController.text,
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
          backgroundColor: const Color.fromARGB(255, 232, 233, 233),
          title: const Text("Create New Meet"),
          surfaceTintColor: const Color.fromARGB(255, 140, 248, 252),
          content: Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
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

                  //weight catagories
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, bottom: 5, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("enter weight catagories separated by commas"),
                        Text('ex: +35,-35, +45,-45'),
                      ],
                    ),
                  ),

                  InputField(
                      labelText: "Weights",
                      controller: weightController,
                      keyboardType: TextInputType.text)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void savingValidationCompetiton(String date, String place, String type,
      BuildContext context, String weights, String competitionName) {
    final validation =
        Validator.addCompetitionValidator(date, place, type, weights);

    if (validation != true) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(validation.toString()),
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
    } else {
      saveCompetition(date, place, type, context, weights, competitionName);
    }
  }

  Future<String> saveCompetition(String date, String place, String type,
      BuildContext context, String weights, String competitionName) async {
    try {
      final uid = auth.getCurrentUserId();
      final db = BlocProvider.of<DbCubit>(context).firestore;

      final newCompetition = <String, dynamic>{
        "userId": uid,
        'name': competitionName,
        'date': date,
        'place': place,
        'type': type,
        'weights': weights,
        'players': <Player>[], //this is to store the student in the grading
      };

      //database creation
      db
          .collection('Competitions')
          .add(newCompetition)
          .then((DocumentReference doc) {
        final newCompetitions = Competition(
            id: doc.id,
            player: [],
            date: DateTime.parse(date),
            name: competitionName,
            place: place,
            type: type,
            weights: weights,
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

  Future<String> deleteCompetiton(
      String competitonId, FirebaseFirestore db) async {
    try {
      await db.collection("Competitions").doc(competitonId).delete();
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  void initialPlayerLoading(Competition competiton, BuildContext context) {
    for (var element in competiton.player) {
      if (element.kata == true) {
        log("adding player to : ${element.level}");
        BlocProvider.of<FedSholCompetitionCubit>(context).addPlayer(element);
      }
    }
  }

  // kumitePlayerList(Competition competiton) {
  //   List<String> weights = competiton.weights.split(',');
  //   List<List<Player>> kumitePlayersListOfList = [];
  // }

  Future<void> addPlayerToDataBase(String competitonId, Player player,
      FirebaseFirestore db, BuildContext context) async {
    List<Competition> competitions =
        BlocProvider.of<FedSholCompetitionCubit>(context).getCompetitions();
    for (var i = 0; i < competitions.length; i++) {
      if (competitions[i].id == competitonId && player.kata == true) {
        competitions[i].player.add(player);
        break;
      }
    }

    BlocProvider.of<FedSholCompetitionCubit>(context)
        .updateCompetitions(competitions);
    BlocProvider.of<FedSholCompetitionCubit>(context).addPlayer(player);

    final itemToAdd = createItemString(player);
    await db.collection("Competitions").doc(competitonId).update({
      'players': FieldValue.arrayUnion([itemToAdd])
    });
  }

  createItemString(Player player) {
    return '${player.name},${player.birthCertificateNumber},${player.level},${player.competeCategory},${player.kata.toString()},${player.kumite.toString()},${player.teamKata.toString()},${player.weight.toString()},${player.paymentStatus}, ${player.paidAmount}, ${player.paidDate}';
  }

  void updatePlayerPaymentDetails(String competitonId,
      Player player, FirebaseFirestore db, BuildContext context) {
    List<Competition> competitions =
        BlocProvider.of<FedSholCompetitionCubit>(context).getCompetitions();
    List<Player> players =
        BlocProvider.of<FedSholCompetitionCubit>(context).getCurrentPlayers();

    for (var i = 0; i < competitions.length; i++) {
      if (competitions[i].id == competitonId) {
        competitions[i].player = players;
      }
    }

    BlocProvider.of<FedSholCompetitionCubit>(context)
        .updateCompetitions(competitions);

    final itemToAdd = createItemString(player);
    db.collection("Competitions").doc(competitonId).update({
      'players': FieldValue.arrayRemove([itemToAdd])
    }).then((value) {
      db.collection("Competitions").doc(competitonId).update({
        'players': FieldValue.arrayUnion([itemToAdd])
      });
    });
  }
}
