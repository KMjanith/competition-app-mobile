import 'dart:developer';

import 'package:competition_app/Constants/KarateEvents.dart';
import 'package:competition_app/Constants/PaymentStatus.dart';
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

class AddPlayers extends StatefulWidget {
  final Competition competition;
  const AddPlayers({super.key, required this.competition});

  @override
  _AddPlayersState createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  final fullNameController = TextEditingController();
  final birthCertificateNumberController = TextEditingController();
  final weightController = TextEditingController();
  final competitionService = CompetitionService();
  String? level;
  String? category;
  String? selectedLevel;
  String? selectedEvent = KarateConst.KATA;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<FedSholCompetitionCubit>(context).clearPlayerLists();
    competitionService.initialKataPlayerLoading(widget.competition, context);
    competitionService.initialKumitePlayerLoading(widget.competition, context);
  }

  @override
  Widget build(BuildContext context) {
    List<Player> l1 =
        BlocProvider.of<FedSholCompetitionCubit>(context).getLv1KataPlayers();
    List<Player> l2 =
        BlocProvider.of<FedSholCompetitionCubit>(context).getLv2KataPlayers();
    List<Player> l3 =
        BlocProvider.of<FedSholCompetitionCubit>(context).getLv3KataPlayers();
    List<Player> l4 =
        BlocProvider.of<FedSholCompetitionCubit>(context).getLv4KataPlayers();
    List<Player> l5 =
        BlocProvider.of<FedSholCompetitionCubit>(context).getLv5KataPlayers();
    List<List<Player>> c = BlocProvider.of<FedSholCompetitionCubit>(context)
        .sortKataPlayerInCategories(widget.competition.player);
    List<Player> c1 = c[0];
    List<Player> c2 = c[1];
    List<Player> c3 = c[2];
    List<Player> c4 = c[3];
    final competitionName = widget.competition.name;

    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
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
                    const Center(
                        child: HeadingAnimation(heading: "Manage Students")),
                    const Center(
                      child: Text(
                        "Add the player details",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      labelText: "Full name",
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
                    ),
                    InputField(
                      labelText: "Birth Certificate Number",
                      controller: birthCertificateNumberController,
                      keyboardType: TextInputType.number,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8, left: 18, right: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(176, 255, 255, 255),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RadioButton(
                              title: KarateConst.KATA,
                              groupValue: selectedEvent ?? '',
                              onChanged: (value) {
                                setState(() {
                                  selectedEvent = value;
                                });
                              },
                            ),
                            RadioButton(
                              title: KarateConst.KUMITE,
                              groupValue: selectedEvent ?? '',
                              onChanged: (value) {
                                setState(() {
                                  selectedEvent = value;
                                });
                              },
                            ),
                            RadioButton(
                              title: KarateConst.TEAMKATA,
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
                    if (selectedEvent != KarateConst.KUMITE &&
                        widget.competition.name !=
                            KarateConst
                                .MINISTRY) // if selected event is not kumite
                      Row(
                        children: [
                          Expanded(
                            child: DropDownInput(
                              onChanged: (value) {
                                category = value;
                              },
                              title: "Category",
                              itemList: AppConstants.catagories
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                            ),
                          ),
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
                    if (selectedEvent != KarateConst.KUMITE &&
                        widget.competition.name ==
                            KarateConst
                                .MINISTRY) // if selected event is not kumite

                      DropDownInput(
                        onChanged: (value) {
                          category = value;
                        },
                        title: "Category",
                        itemList: AppConstants.catagories
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                      ),
                    if (selectedEvent !=
                        KarateConst.KATA) // if selected event is not kata
                      Row(
                        children: [
                          Expanded(
                            child: DropDownInput(
                              onChanged: (value) {
                                category = value;
                              },
                              title: "Category",
                              itemList: AppConstants.catagories
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: InputField(
                              labelText: "Weight",
                              controller: weightController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
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
                                  addPlayer(widget.competition.id);
                                },
                                child: const Text(
                                  "Add Player",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 19),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      // kata players display
                      child: Text(
                        textAlign: TextAlign.start,
                        "KATA Players",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    if (widget.competition.name == "Federation" ||
                        widget.competition.name == "School")
                      Column(
                        children: [
                          KatKumiteTile(
                            competitonName:competitionName,
                            competitonId: widget.competition.id,
                            players: l1,
                            title: AppConstants.levels[0],
                            itemCount: l1.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: l2,
                            title: AppConstants.levels[1],
                            itemCount: l2.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: l3,
                            title: AppConstants.levels[2],
                            itemCount: l3.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: l4,
                            title: AppConstants.levels[3],
                            itemCount: l4.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: l5,
                            title: AppConstants.levels[4],
                            itemCount: l5.length.toString(),
                          ),
                        ],
                      ),
                    if (widget.competition.name == "Ministry")
                      Column(
                        children: [
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: c1,
                            title: AppConstants.catagories[0],
                            itemCount: c1.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: c2,
                            title: AppConstants.catagories[1],
                            itemCount: c2.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: c3,
                            title: AppConstants.catagories[2],
                            itemCount: c3.length.toString(),
                          ),
                          KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            players: c4,
                            title: AppConstants.catagories[3],
                            itemCount: c4.length.toString(),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    const Center(
                      // kumite players display
                      child: Text(
                        textAlign: TextAlign.start,
                        "KUMITE Players",
                        style: TextStyle(color: Color.fromARGB(255, 0, 9, 92)),
                      ),
                    ),
                  ],
                ),
              ),

              //kumite players
              BlocBuilder<FedSholCompetitionCubit, FedSholCompetitionState>(
                builder: (context, state) {
                  if (state is FedSholCompetitonLoaded) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return KatKumiteTile(
                            competitonName: competitionName,
                            competitonId: widget.competition.id,
                            itemCount: state.kumitePlayers.values
                                .toList()[index]
                                .length
                                .toString(),
                            players: state.kumitePlayers.values.toList()[index],
                            title: state.kumitePlayers.keys.toList()[index],
                          );
                        },
                        childCount: state.kumitePlayers.length,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addPlayer(String competitionId) {
    final db = BlocProvider.of<DbCubit>(context).firestore;
    if (weightController.text.isEmpty) {
      weightController.text = '0';
    }
    final player = Player(
      name: fullNameController.text,
      birthCertificateNumber: birthCertificateNumberController.text,
      level: level ?? '',
      competeCategory: category ?? '',
      kata: selectedEvent == KarateConst.KATA,
      kumite: selectedEvent == KarateConst.KUMITE,
      teamKata: selectedEvent == KarateConst.TEAMKATA,
      weight: int.parse(weightController.text),
      paymentStatus: PaymentStatus.pending,
      paidAmount: '',
      paidDate: '',
    );

    final competitionService = CompetitionService();

    dynamic validation = Validator.addCompetitionPlayerValidator(
      widget.competition.name,
      selectedEvent ?? '',
      fullNameController.text,
      birthCertificateNumberController.text,
      level ?? '',
      category ?? '',
      weightController.text,
    );

    if (validation == true) {
      competitionService.addPlayerToDataBase(
          competitionId, player, db, context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 8, 95, 0),
        content: Text(
          "Player added successfully!",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
      setState(() {
        fullNameController.clear();
        birthCertificateNumberController.clear();
        weightController.clear();
        selectedLevel = '';
        category = '';
        selectedEvent = KarateConst.KATA;
      });
    } else {
      log("validation passed : $validation");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error adding Player: $validation",
          style: GoogleFonts.alegreya(fontSize: 20),
        ),
      ));
    }
  }
}
