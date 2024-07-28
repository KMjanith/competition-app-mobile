import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/Constants/KarateEvents.dart';
import 'package:competition_app/Constants/PaymentStatus.dart';
import 'package:competition_app/components/inputs/Inputs.dart';
import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/cubit/fed_shol_competiton_cubit.dart';
import 'package:competition_app/services/CompetitionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../../Constants/AppConstants.dart';
import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/DatePickerInput.dart';
import '../../components/inputs/DropDownInput.dart';

import '../../model/Player.dart';
import '../../services/Validator.dart';

class PlayersDisplay extends StatefulWidget {
  final String competitionName;
  final String competitonId;
  final String heading;
  final List<Player> players;
  const PlayersDisplay(
      {super.key,
      required this.players,
      required this.heading,
      required this.competitonId,
      required this.competitionName});

  @override
  State<PlayersDisplay> createState() => _PlayersDisplayState();
}

class _PlayersDisplayState extends State<PlayersDisplay> {
  get heading => widget.heading;
  final competitionService = CompetitionService();

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      paymentTimeController.text = picked.toString().split(' ')[0];
    }
  }

  final TextEditingController paymentTimeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String? paymentStatus;

  void showPaymentDetailsPopUp(Player player) {
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
                      updatePaymentDetails(player);
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Color.fromARGB(255, 7, 0, 39)),
                    ),
                  ),
                ),
              ],
            ),
          ],
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          title: const Text("Edit Payment Details", style: TextStyle(color: Colors.white),),
          surfaceTintColor: const Color.fromARGB(255, 140, 248, 252),
          content: Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DatePickerInput(
                    dateController: paymentTimeController,
                    selectedDate: _selectDate,
                    lableName: "Paid Date",
                  ),
                  DropDownInput(
                      onChanged: (value) {
                        paymentStatus = value;
                      },
                      title: "Payment Status",
                      itemList: AppConstants.paymentStatus),
                  InputField(
                      labelText: "Amount",
                      controller: amountController,
                      keyboardType: TextInputType.number)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void updatePaymentDetails(Player player) {
    log("player: ${player.name}");
    player.paidDate = paymentTimeController.text;
    player.paidAmount = amountController.text;
    player.paymentStatus = paymentStatus!;

    final allset = Validator.playerPaymentDetailsValidator(player);
    log("allset $allset");
    final db = BlocProvider.of<DbCubit>(context).firestore;
    if (allset != true) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: allset,
        onCancelBtnTap: () {
          Navigator.of(context).pop();
        },
      );
    } else if (player.kata &&
        (widget.competitionName == KarateConst.FEDERATION ||
            widget.competitionName == KarateConst.SCHOOL)) {
      if (player.level == AppConstants.levels[0]) {
        BlocProvider.of<FedSholCompetitionCubit>(context)
            .setL1List(widget.players);
        updateTheDatabase(widget.competitonId, player, db, context);
      }
      if (player.level == AppConstants.levels[1]) {
        BlocProvider.of<FedSholCompetitionCubit>(context)
            .setL2List(widget.players);
        updateTheDatabase(widget.competitonId, player, db, context);
      }
      if (player.level == AppConstants.levels[2]) {
        BlocProvider.of<FedSholCompetitionCubit>(context)
            .setL3List(widget.players);
        updateTheDatabase(widget.competitonId, player, db, context);
      }
      if (player.level == AppConstants.levels[3]) {
        BlocProvider.of<FedSholCompetitionCubit>(context)
            .setL4List(widget.players);
        updateTheDatabase(widget.competitonId, player, db, context);
      }
      if (player.level == AppConstants.levels[4]) {
        BlocProvider.of<FedSholCompetitionCubit>(context)
            .setL5List(widget.players);
        updateTheDatabase(widget.competitonId, player, db, context);
      }
    } else {
      updateTheDatabase(widget.competitonId, player, db, context);
    }
  }

  void updateTheDatabase(String competitonId, Player player,
      FirebaseFirestore db, BuildContext context) async {
    final result = await competitionService.updatePlayerPaymentDetails(
        widget.competitonId, player, db, context, widget.competitionName);
    log(result);
    if (result == "Success") {
      setState(() {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Success',
          text: 'Payment Details Updated',
          onConfirmBtnTap: () {
            paymentTimeController.clear();
            amountController.clear();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      });
    } else {
      setState(() {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: result,
          onCancelBtnTap: () {
            Navigator.of(context).pop();
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          Column(
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
              HeadingAnimation(heading: "$heading"),
              const Text(
                "All Players Details are here",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child:
                  BlocBuilder<FedSholCompetitionCubit, FedSholCompetitionState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.players.length,
                    itemBuilder: (context, index) {
                      Color frontColor;
                      Color backColor;
                      if (widget.players[index].paymentStatus ==
                          PaymentStatus.pending) {
                        frontColor = const Color.fromARGB(255, 255, 194, 189);
                        backColor = const Color.fromARGB(66, 221, 221, 221);
                      } else {
                        frontColor = const Color.fromARGB(255, 174, 250, 151);
                        backColor = const Color.fromARGB(192, 216, 216, 216);
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: backColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  height: 100,
                                  width: 270,
                                  decoration: BoxDecoration(
                                      color: frontColor,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15),
                                          topRight: Radius.circular(55),
                                          bottomRight: Radius.circular(55))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          details("Name ",
                                              widget.players[index].name),
                                          details(
                                              "Birth.C Number",
                                              widget.players[index]
                                                  .birthCertificateNumber),
                                          if (widget.players[index].kata)
                                            details("level",
                                                widget.players[index].level),
                                          details(
                                              "competeCategory",
                                              widget.players[index]
                                                  .competeCategory),
                                          if (widget.players[index].kumite)
                                            details(
                                                "weight",
                                                widget.players[index].weight
                                                    .toString()),
                                          details(
                                              "Payments",
                                              widget.players[index]
                                                  .paymentStatus),
                                          if (widget.players[index]
                                                  .paymentStatus !=
                                              PaymentStatus.pending)
                                            details("Paid Date",
                                                widget.players[index].paidDate),
                                          if (widget.players[index]
                                                  .paymentStatus !=
                                              PaymentStatus.pending)
                                            details(
                                                "Amount",
                                                widget
                                                    .players[index].paidAmount),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 224, 255, 207),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: TextButton(
                                          child: const Text(
                                            "Payments",
                                          ),
                                          onPressed: () {
                                            showPaymentDetailsPopUp(
                                                widget.players[index]);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          )
        ],
      ),
    );
  }

  Row details(String key, String value) {
    return Row(
      children: [
        const Icon(Icons.arrow_right_rounded),
        Text(
          key,
          style: const TextStyle(
              color: Color.fromARGB(
                255,
                0,
                0,
                0,
              ),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
