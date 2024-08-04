import 'package:competition_app/cubit/fed_shol_competiton_cubit.dart';
import 'package:competition_app/model/Competition.dart';
import 'package:competition_app/pages/competition/PastCompetitonDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../cubit/db_cubit.dart';
import '../../services/CompetitionService.dart';


class PastCompetitions extends StatefulWidget {
  const PastCompetitions({super.key});

  @override
  State<PastCompetitions> createState() => _PastCompetitionsState();
}

class _PastCompetitionsState extends State<PastCompetitions> {
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
                          color: Color.fromARGB(255, 250, 250, 250)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "Past Meets Details"),
              const Text(
                "All Pats Meet details are shown here",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<FedSholCompetitionCubit,
                    FedSholCompetitionState>(
                  builder: (context, state) {
                    if (state is FedSholCompetitonLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FedSholCompetitonLoaded) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.competitions.length,
                          itemBuilder: (context, index) {
                            var today = DateTime.now();
                            var gradingDate = state.competitions[index].date;

                            if (gradingDate.isBefore(today)) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: StyleConstants.cardBackGround,
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 75,
                                  child: Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {}),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) => {
                                            doNothing(
                                                context,
                                                state.competitions[index].id,
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
                                        //Navigate to the details page
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PastCompetitionDetails(competiton: state.competitions[index],)));
                                      },
                                      trailing: const Icon(Icons.menu),
                                      leading: const Icon(
                                          Icons.account_tree_rounded),
                                      tileColor: const Color.fromARGB(
                                          255, 12, 110, 160),
                                      title: Text(
                                        state.competitions[index].place,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      subtitle: Text(state
                                          .competitions[index].date
                                          .toString()
                                          .split(" ")[0]),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox
                                .shrink(); // Return an empty container to avoid null
                          });
                    }
                    return const SizedBox.shrink();
                  },
                ),
              )
            ],
          )
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
    if (result == "Success") {
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
}
