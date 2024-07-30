import 'package:competition_app/Constants/KarateEvents.dart';
import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:competition_app/cubit/score_board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/ScoreBoard.dart';
import 'ScoreBoard.dart';

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
    context.read<ScoreBoardCubit>().loadScoreBoard();
    final scoreBoard1 = Scoreboard(
        akaPlayerName: "John",
        awoPLayerName: "Doe",
        timeDuration: "10",
        akaPlayerPoints: [1, 1, 1],
        awoPlayerPoints: [1, 1, 1],
        winner: KarateConst.AKA,
        akaPenalties: ["l1", "l2"],
        awoPenalties: ["l1", "l2"],
        firstPoint: KarateConst.AKA);
    final scoreBoard2 = Scoreboard(
        akaPlayerName: "John",
        awoPLayerName: "Doe",
        timeDuration: "10",
        akaPlayerPoints: [1, 1, 1],
        awoPlayerPoints: [1, 1, 1],
        winner: KarateConst.AKA,
        akaPenalties: ["l1", "l2"],
        awoPenalties: ["l1", "l2"],
        firstPoint: KarateConst.AKA);
    final scoreBoard3 = Scoreboard(
        akaPlayerName: "John",
        awoPLayerName: "Doe",
        timeDuration: "10",
        akaPlayerPoints: [1, 1, 1],
        awoPlayerPoints: [1, 1, 1],
        winner: KarateConst.AKA,
        akaPenalties: ["l1", "l2"],
        awoPenalties: ["l1", "l2"],
        firstPoint: KarateConst.AKA);

    BlocProvider.of<ScoreBoardCubit>(context).addScoreBoard(scoreBoard1);
    BlocProvider.of<ScoreBoardCubit>(context).addScoreBoard(scoreBoard2);
    BlocProvider.of<ScoreBoardCubit>(context).addScoreBoard(scoreBoard3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScoreBoard(
                                akaPlayerName: (akaPLayerNameController.text == "") ? "No name" : akaPLayerNameController.text,
                                awoPlayerName: awoPLayerNameCOntroller.text == "" ? "No name" : awoPLayerNameCOntroller.text,
                                minutes:
                                    int.parse(minuteDurationController.text),
                                seconds:
                                    int.parse(secondDurationController.text),
                              )));
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
                  height: 20,
                ),
                const Text("Recent Matches",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 1000,
                  width: double.infinity,
                  child: BlocBuilder<ScoreBoardCubit, ScoreBoardState>(
                    builder: (context, state) {
                      if (state is ScoreBoardLoaded) {
                        return ListView.builder(
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
                                  title: Text(
                                    "AKA: ${state.scoreBoards[index].akaPlayerName}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    "AWO: ${index + 1}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {},
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
          )
        ],
      ),
    );
  }
}
