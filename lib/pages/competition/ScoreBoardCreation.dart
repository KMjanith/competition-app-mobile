import 'package:competition_app/components/Constants/StyleConstants.dart';
import 'package:competition_app/cubit/score_board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../cubit/db_cubit.dart';
import '../../services/ScoreBoardServices.dart';
import 'ScoreBoard.dart';
import 'ScoreBoardDetailsPage.dart';

class ScoreBoardCreation extends StatefulWidget {
  const ScoreBoardCreation({super.key});

  @override
  State<ScoreBoardCreation> createState() => _ScoreBoardCreationState();
}

class _ScoreBoardCreationState extends State<ScoreBoardCreation> {
  final TextEditingController akaPLayerNameController = TextEditingController();
  final TextEditingController awoPLayerNameCOntroller = TextEditingController();
  final TextEditingController minuteDurationController =
      TextEditingController();
  final TextEditingController secondDurationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ScoreBoardCubit>().loadScoreBoard(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    akaPLayerNameController.dispose();
    awoPLayerNameCOntroller.dispose();
    minuteDurationController.dispose();
    secondDurationController.dispose();
    akaPLayerNameController.clear();
    awoPLayerNameCOntroller.clear();
    minuteDurationController.clear();
    secondDurationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 90),

                const HeadingAnimation(heading: "Make new Fight"),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InputField(
                            labelText: "AKA Player Name",
                            controller: akaPLayerNameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        Expanded(
                          child: InputField(
                              labelText: "AWO Player Name",
                              controller: awoPLayerNameCOntroller,
                              keyboardType: TextInputType.text),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InputField(
                              labelText: "Minutes",
                              controller: minuteDurationController,
                              keyboardType: TextInputType.number),
                        ),
                        Expanded(
                          child: InputField(
                              labelText: "Seconds",
                              controller: secondDurationController,
                              keyboardType: TextInputType.number),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                //create new score board
                SizedBox(
                  width: 150,
                  height: 50,
                  child: FloatingActionButton(
                    backgroundColor: Color.fromARGB(255, 77, 218, 236),
                    onPressed: () {
                      if (minuteDurationController.text == "" ||
                          secondDurationController.text == "") {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          text: 'Please enter the minutes and seconds',
                        );
                      } else {
                        String akaPlayerName =
                            akaPLayerNameController.text.isEmpty
                                ? "No name"
                                : akaPLayerNameController.text;
                        String awoPlayerName =
                            awoPLayerNameCOntroller.text.isEmpty
                                ? "No name"
                                : awoPLayerNameCOntroller.text;
                        int minutes = int.parse(minuteDurationController.text);
                        int seconds = int.parse(secondDurationController.text);

                        // Clear the input fields before navigating
                        akaPLayerNameController.clear();
                        awoPLayerNameCOntroller.clear();
                        minuteDurationController.clear();
                        secondDurationController.clear();

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScoreBoard(
                              akaPlayerName: akaPlayerName,
                              awoPlayerName: awoPlayerName,
                              minutes: minutes,
                              seconds: seconds,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "start fight",
                            style: TextStyle(
                                color: Color.fromARGB(255, 2, 62, 110),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.add_box_sharp,
                            color: Color.fromARGB(255, 2, 62, 110),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                //current score boards
                const SizedBox(
                  height: 10,
                ),
                const Text("Recent Matches",
                    style: TextStyle(color: Colors.white)),

                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: BlocBuilder<ScoreBoardCubit, ScoreBoardState>(
                    builder: (context, state) {
                      if (state is ScoreBoardLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ScoreBoardLoaded) {
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 15),
                          itemCount: state.scoreBoards.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 2, 62, 110),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                (ScoreBoardDetailsPage(
                                                  scoreboardDetails:
                                                      state.scoreBoards[index],
                                                ))));
                                  },
                                  title: Text(
                                    "Date: ${state.scoreBoards[index].date}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    "winner: ${state.scoreBoards[index].winner}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.confirm,
                                          text:
                                              "Are you sure you want to delete this score board?",
                                          onCancelBtnTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          onConfirmBtnTap: () {
                                            final db = context
                                                .read<DbCubit>()
                                                .firestore;
                                            ScoreBoardServices()
                                                .deleteScoreBoardDetails(
                                                    db,
                                                    state
                                                        .scoreBoards[index].id);
                                            context
                                                .read<ScoreBoardCubit>()
                                                .deleteScoreBoard(index);
                                            Navigator.of(context).pop();
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: SizedBox.shrink(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
