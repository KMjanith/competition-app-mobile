import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/components/Constants/KarateEvents.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../components/Constants/AppConstants.dart';
import '../../../cubit/fed_shol_competiton_cubit.dart';
import '../../../model/Competition.dart';
import '../../../model/Player.dart';
import '../components/inputs/DatePickerInput.dart';
import '../components/inputs/DropDownInput.dart';
import '../components/inputs/Inputs.dart';
import '../components/inputs/YeasOrNoInput.dart';
import 'AuthService.dart';
import 'Validator.dart';

class CompetitionService {
  final auth = Authservice();

  void createNewCompetitionPopUp(BuildContext context, String competitionName) {
    final TextEditingController meetTimeController = TextEditingController();
    final TextEditingController meetPlaceController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController customAgeController = TextEditingController();

    String? selectedType;
    String? useLevels; // Variable to store yes/no selection

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

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                          savingValidatedCompetiton(
                              meetTimeController.text,
                              meetPlaceController.text,
                              selectedType ?? "",
                              context,
                              weightController.text,
                              competitionName);
                        },
                        child: const Text(
                          "Create",
                          style:
                              TextStyle(color: Color.fromARGB(255, 7, 0, 39)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              backgroundColor: Color.fromARGB(255, 31, 31, 31),
              title: const Text(
                "Create New Meet",
                style: TextStyle(color: Colors.white),
              ),
              content: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DatePickerInput(
                        dateController: meetTimeController,
                        selectedDate: _selectDate,
                        labelName: "Date",
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
                      if (competitionName == KarateConst.FEDERATION ||
                          competitionName == KarateConst.SCHOOL ||
                          competitionName == KarateConst.MINISTRY)
                        Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Enter weight categories separated by commas",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 179, 218, 250)),
                                  ),
                                  Text(
                                    'ex: +35,-35, +45,-45',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            InputField(
                                labelText: "Weights",
                                controller: weightController,
                                keyboardType: TextInputType.text)
                          ],
                        ),
                      if (competitionName == KarateConst.CUSTOM)
                        Column(
                          children: [
                            YeasOrNoInput(
                              title: 'Use levels?',
                              groupValue: useLevels,
                              onChanged: (value) {
                                setState(() {
                                  useLevels = value;
                                });
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "* Enter weight categories separated by commas for kumite",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 136, 199, 250)),
                                  ),
                                  Text(
                                    'ex: +35,-35, +45,-45',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            InputField(
                                labelText: "Weights",
                                controller: weightController,
                                keyboardType: TextInputType.text),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "* Enter Age categories separated by commas. ",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 136, 199, 250))),
                                  Text('ex: 8-9-10,16-17, 18-19, 20-21',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            InputField(
                                labelText: "age categories",
                                controller: customAgeController,
                                keyboardType: TextInputType.text),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void savingValidatedCompetiton(String date, String place, String type,
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
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'New Competition added successfully!',
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      }).catchError((error) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: "Failed to add new Grading: $error",
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
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

  //initial kata players loading method
  void initialKataPlayerLoading(Competition competiton, BuildContext context) {
    for (var element in competiton.player) {
      if (element.kata == true) {
        BlocProvider.of<FedSholCompetitionCubit>(context).addPlayer(element);
      }
    }
  }

  //initial kumite players loading method
  void initialKumitePlayerLoading(
      Competition competiton, BuildContext context) {
    List<String> weights = competiton.weights.split(',');
    Map<String, List<Player>> kumitePlayersListOfList = {};

    for (var stringWeight in weights) {
      kumitePlayersListOfList[stringWeight] = [];
    }

    for (var player in competiton.player) {
      if (player.kumite == true && player.kata != true) {
        String? keyToAddPLayer =
            findWeightCategory(kumitePlayersListOfList, player.weight);
        kumitePlayersListOfList[keyToAddPLayer]?.add(player);
      }
    }

    BlocProvider.of<FedSholCompetitionCubit>(context)
        .addKumitePlayers(kumitePlayersListOfList);
  }

  //finding the right list to add the kumite player
  String? findWeightCategory(
      Map<String, List<Player>> kumitePLayers, int weight) {
    //list to get the sorted weight categories
    List<int> sortedWeightCategories = [];
    kumitePLayers.forEach(
      (key, value) {
        final regex = RegExp(r'[+-]?\d+');
        final match = regex.firstMatch(key);
        final weightString = match!.group(0)!.replaceAll(RegExp(r'[+-]'), '');
        sortedWeightCategories.add(int.parse(weightString));
      },
    );
    sortedWeightCategories.sort();
    Map<int, String> tempMap = {}; //for index mapping
    for (var i = 0; i < sortedWeightCategories.length; i++) {
      if (i < sortedWeightCategories.length - 1) {
        tempMap[i] = "-${sortedWeightCategories[i].toString()}";
      } else {
        tempMap[i] = "+${sortedWeightCategories[i].toString()}";
      }
    }

    var playerWeight = weight;
    var index = 0;
    while (playerWeight >= sortedWeightCategories[index]) {
      if (index == sortedWeightCategories.length - 1) {
        break;
      }
      index++;
    }

    return tempMap[index];
  }

  //method to add player to the database
  Future<void> addPlayerToDataBase(String competitonId, Player player,
      FirebaseFirestore db, BuildContext context) async {
    List<Competition> competitions =
        BlocProvider.of<FedSholCompetitionCubit>(context).getCompetitions();

    for (var i = 0; i < competitions.length; i++) {
      if (competitions[i].id == competitonId) {
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

  String createItemString(Player player) {
    return '${player.name},${player.birthCertificateNumber},${player.level},${player.competeCategory},${player.kata.toString()},${player.kumite.toString()},${player.teamKata.toString()},${player.weight.toString()},${player.paymentStatus}, ${player.paidAmount}, ${player.paidDate}';
  }

  Future<String> updatePlayerPaymentDetails(
      String competitonId,
      Player player,
      FirebaseFirestore db,
      BuildContext context,
      String competitionType) async {
    List<Player> players = BlocProvider.of<FedSholCompetitionCubit>(context)
        .allPLayer(competitionType);

    try {
      await db.collection("Competitions").doc(competitonId).update(
          {'players': players.map((e) => createItemString(e)).toList()});

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}
