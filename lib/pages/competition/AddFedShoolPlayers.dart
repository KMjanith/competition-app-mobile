import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/cubit/fed_shol_competiton_cubit.dart';
import 'package:competition_app/model/Competition.dart';
import 'package:competition_app/model/Player.dart';
import 'package:competition_app/services/CompetitionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/AppConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/competition/kataKumiteTile.dart';
import '../../components/inputs/DropDownInput.dart';
import '../../components/inputs/Inputs.dart';
import '../../components/inputs/radioButton.dart';
import '../../services/Validator.dart';

class AddFedShoolPlayers extends StatefulWidget {
  final Competition competiton;
  const AddFedShoolPlayers({super.key, required this.competiton});

  @override
  _AddFedShoolPlayersState createState() => _AddFedShoolPlayersState();
}

class _AddFedShoolPlayersState extends State<AddFedShoolPlayers> {
  final fullNameController = TextEditingController();
  final birthCertificateNumberController = TextEditingController();
  final weightController = TextEditingController();
  final competitonService = CompetitionService();
  String? level;
  String? category;
  String? selectedLevel;
  String? selectedEvent;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<FedSholCompetitionCubit>(context).clearPlayerLists();
    competitonService.initialPlayerLoading(widget.competiton, context);
  }

  // List<Player> kumitePlayerList(String level) {
  //   final competitonService = CompetitionService();
  //   final playerList = competitonService.kumitePlayerList(widget.competiton);
  //   return playerList;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(Icons.menu,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
                const HeadingAnimation(heading: "Manage Students"),
                const Text(
                  "Add the player details",
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),

                //fulName
                InputField(
                  labelText: "full name",
                  controller: fullNameController,
                  keyboardType: TextInputType.text,
                ),

                //birthcertificate
                InputField(
                  labelText: "Birth Certificate Number",
                  controller: birthCertificateNumberController,
                  keyboardType: TextInputType.number,
                ),

                //radio kata, kumite, team even buttons
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 18, right: 18),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(176, 255, 255, 255),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //kata
                        RadioButton(
                          title: "Kata",
                          groupValue: selectedEvent ?? '',
                          onChanged: (value) {
                            setState(() {
                              selectedEvent = value;
                            });
                          },
                        ),
                        //kumite
                        RadioButton(
                          title: "Kumite",
                          groupValue: selectedEvent ?? '',
                          onChanged: (value) {
                            setState(() {
                              selectedEvent = value;
                            });
                          },
                        ),
                        //teamKata
                        RadioButton(
                          title: "Team Kata",
                          groupValue: selectedEvent ?? '',
                          onChanged: (value) {
                            setState(() {
                              selectedEvent = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    //category selector
                    Expanded(
                      child: DropDownInput(
                        onChanged: (value) {
                          category = value;
                        },
                        title: "category",
                        itemList: AppConstants.catagories
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                      ),
                    ),

                    //level selector
                    Expanded(
                      child: DropDownInput(
                        onChanged: (value) {
                          level = value;
                        },
                        title: "Level",
                        itemList: AppConstants.levels
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),

                if (selectedEvent != 'Kata')
                  //weight
                  InputField(
                      labelText: "Weight",
                      controller: weightController,
                      keyboardType: TextInputType.number),

                //submit and cancel buttons
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 19, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: StyleConstants.submitButtonColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                          ),
                          width: 300,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              addKataPlayer(widget.competiton.id);
                              setState(() {
                                fullNameController.clear();
                                birthCertificateNumberController.clear();
                                weightController.clear();
                                selectedLevel = '';
                                category = '';
                                selectedEvent = '';
                              });
                            },
                            child: const Text(
                              "Add Player",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, right: 19),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: StyleConstants.cancelButtonColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                        ),
                        width: 100,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            fullNameController.clear();
                            birthCertificateNumberController.clear();
                            weightController.clear();
                            selectedLevel = '';
                            category = '';
                            selectedEvent = '';
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                //current Student show area
                const Text(
                  textAlign: TextAlign.start,
                  "KATA Players",
                  style: TextStyle(color: Colors.white),
                ),

                //Kata tiles
                KatKumiteTile(
                  players: BlocProvider.of<FedSholCompetitionCubit>(context)
                      .getLv1KataPlayers(),
                  title: AppConstants.levels[0],
                ),
                KatKumiteTile(
                  players: BlocProvider.of<FedSholCompetitionCubit>(context)
                      .getLv2KataPlayers(),
                  title: AppConstants.levels[1],
                ),
                KatKumiteTile(
                  players: BlocProvider.of<FedSholCompetitionCubit>(context)
                      .getLv3KataPlayers(),
                  title: AppConstants.levels[2],
                ),
                KatKumiteTile(
                  players: BlocProvider.of<FedSholCompetitionCubit>(context)
                      .getLv4KataPlayers(),
                  title: AppConstants.levels[3],
                ),
                KatKumiteTile(
                  players: BlocProvider.of<FedSholCompetitionCubit>(context)
                      .getLv5KataPlayers(),
                  title: AppConstants.levels[4],
                ),

                const SizedBox(
                  height: 10,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "KUMITE Players",
                  style: TextStyle(color: Colors.white),
                ),

                // const KatKumiteTile(
                //   players: [],
                //   title: "Weight(-35KG)",
                // ),
                // const KatKumiteTile(
                //   players: [],
                //   title: "Weight(+35KG)",
                // ),
                // const KatKumiteTile(
                //   players: [],
                //   title: "Weight(-45KG)",
                // ),
                // const KatKumiteTile(
                //   players: [],
                //   title: "Weight(+45KG)",
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addKataPlayer(String competitonId) {
    final db = BlocProvider.of<DbCubit>(context).firestore;
    if (weightController.text.isEmpty) {
      weightController.text = '0';
    }
    final player = Player(
      name: fullNameController.text,
      birthCertificateNumber: birthCertificateNumberController.text,
      level: level ?? '',
      competeCategory: category ?? '',
      kata: selectedEvent == 'Kata',
      kumite: selectedEvent == 'Kumite',
      teamKata: selectedEvent == 'Team Kata',
      weight: int.parse(weightController.text),
    );
    final competitonService = CompetitionService();

    try {
      dynamic validation = Validator.addCompetitionPlayerValidator(
          fullNameController.text,
          birthCertificateNumberController.text,
          level ?? '',
          category ?? '',
          weightController.text);

      if (validation) {
        competitonService.addPlayerToDataBase(
            competitonId, player, db, context);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 8, 95, 0),
          content: Text(
            "Player added successfully!",
            style: GoogleFonts.alegreya(fontSize: 20),
          ),
        ));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color.fromARGB(255, 189, 2, 2),
          content: Text(
            "Error adding PLayer: $validation",
            style: GoogleFonts.alegreya(fontSize: 20),
          ),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error adding PLayer: $e",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
    }
  }
}
