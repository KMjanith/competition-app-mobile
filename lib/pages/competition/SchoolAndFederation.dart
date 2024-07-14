import 'package:competition_app/cubit/db_cubit.dart';
import 'package:competition_app/pages/competition/AddFedShoolPlayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Constants/StyleConstants.dart';
import '../../components/buttons/CreateGradingButon.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/common/NothingWidget.dart';
import '../../cubit/fed_shol_competiton_cubit.dart';
import '../../model/Competition.dart';
import '../../services/CompetitionService.dart';

class SchoolAndFederation extends StatefulWidget {
  final String type;
  final String headingTitle;
  const SchoolAndFederation(
      {super.key, required this.headingTitle, required this.type});

  @override
  State<SchoolAndFederation> createState() => _SchoolAndFederationState();
}

class _SchoolAndFederationState extends State<SchoolAndFederation> {
  void goToPage(Competition competiton) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddFedShoolPlayers(competiton: competiton,)));
  }

  @override
  void initState() {
    super.initState();
    final db = BlocProvider.of<DbCubit>(context).firestore;
    BlocProvider.of<FedSholCompetitionCubit>(context)
        .loadCompetitions(db, widget.type);
    
  }

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
                HeadingAnimation(heading: widget.headingTitle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //create a new Grading
                    CreateWhiteButon(
                        callback: () {
                          createCompetition(context);
                        },
                        buttonTitle: 'CREATE MEET'),

                    //Past Grading
                    CreateWhiteButon(
                        callback: () {}, buttonTitle: 'PAST MEETS'),
                  ],
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Next Meet",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 450,
                    child: BlocBuilder<FedSholCompetitionCubit,
                        FedSholCompetitionState>(
                      builder: (context, state) {
                        if (state is FedSholCompetitonLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is FedSholCompetitonLoaded) {
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: state.competitions.length,
                              itemBuilder: (context, index) {
                                var today = DateTime.now();
                                var gradingDate =
                                    state.competitions[index].date;
                                var x = 0;
                                if (gradingDate.isAfter(today)) {
                                  x = 1;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          gradient:
                                              StyleConstants.cardBackGround,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      height: 75,
                                      child: Slidable(
                                        key: const ValueKey(0),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          dismissible: DismissiblePane(
                                              onDismissed: () {}),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) => {
                                                doNothing(
                                                    context,
                                                    state
                                                        .competitions[index].id,
                                                    index,
                                                    state.competitions)
                                              },
                                              backgroundColor:
                                                  const Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Delete',
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            goToPage(state.competitions[index]);
                                          },
                                          trailing: const Icon(Icons.menu),
                                          leading: const Icon(
                                              Icons.account_tree_rounded),
                                          tileColor: const Color.fromARGB(
                                              255, 12, 110, 160),
                                          title: Text(
                                            state.competitions[index].place,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: Text(state
                                              .competitions[index].date
                                              .toString()
                                              .split(" ")[0]),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (x == 0) {
                                  return const NothingWidget(
                                      content: "No Recent Competitions found",
                                      icon: Icons.error);
                                }
                                return const SizedBox
                                    .shrink(); // Return an empty container to avoid null
                              });
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void doNothing(BuildContext context, String competitionId, int index,
      List<Competition> currentList) async {
    final competitionService = CompetitionService();

    final db = BlocProvider.of<DbCubit>(context).firestore;
    String result = await competitionService.deleteCompetiton(
        competitionId, db); // Await deletion
    if (result == "Success" ) {
      //update the state
      BlocProvider.of<FedSholCompetitionCubit>(context)
          .deleteCompetiton(index, currentList);
          
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 18, 189, 2),
        content: Text(
          "Successfully deleted the competition with ID: $competitionId",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error deleting competiton: ${result.toString()}",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  void createCompetition(BuildContext context) {
    final competitionService = CompetitionService();
    competitionService.createNewCompetitionPopUp(context, widget.type);
  }
}
