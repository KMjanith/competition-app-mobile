import 'package:competition_app/blocs/cubit/past_grading_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../Constants/StyleConstants.dart';
import '../../blocs/cubit/recentgradings_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/common/NothingWidget.dart';
import '../../model/Grading.dart';
import '../../services/GradingService.dart';
import 'PastGradinDetails.dart';

class Pastgradings extends StatefulWidget {
  const Pastgradings({Key? key}) : super(key: key);

  @override
  State<Pastgradings> createState() => _PastgradingsState();
}

class _PastgradingsState extends State<Pastgradings> {
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
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "Past Gradings"),
              const Text(
                "click one to see the details",
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 400,
                child:
                    BlocBuilder<RecentgradingsCubit, RecentgradingsCubitState>(
                  builder: (context, state) {
                    if (state is RecentgradingsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RecentgradingsLoaded) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.grading.length,
                        itemBuilder: (context, index) {
                          var x = 0;
                          var today = DateTime.now();
                          var gradingDate =
                              DateTime.parse(state.grading[index].gradingTime);
                          if (gradingDate.isBefore(today)) {
                            x = 1;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: StyleConstants.cardBackGround,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                height: 75,
                                child: Slidable(
                                  key: const ValueKey(0),
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),

                                    dismissible:
                                        DismissiblePane(onDismissed: () {}),

                                    // All actions are defined in the children parameter.
                                    children: [
                                      // A SlidableAction can have an icon and/or a label.
                                      SlidableAction(
                                        onPressed: (context) => {
                                          doNothing(
                                              context,
                                              state.grading[index].id,
                                              index,
                                              state.grading)
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      BlocProvider.of<PastGradingDetailsCubit>(
                                              context)
                                          .loadData(state.grading[index]
                                              .gradingStudentDetails);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PastGradinDetails(
                                                    grading:
                                                        state.grading[index],
                                                  )));
                                    },
                                    trailing: const Icon(Icons.menu),
                                    leading:
                                        const Icon(Icons.account_tree_rounded),
                                    title: Text(
                                      state.grading[index].gradingPlace,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    subtitle:
                                        Text(state.grading[index].gradingTime),
                                  ),
                                ),
                              ),
                            );
                          } else if (x == 0) {
                            return const NothingWidget(content:"No Past Gradings Found", icon: Icons.error);
                          }
                          return const SizedBox.shrink();
                        },
                      );
                    } 
                    // Handle other states if necessary
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void doNothing(BuildContext context, String gradingId, int index,
      List<Grading> list) async {
    final Gradingservice gradingservice = Gradingservice();
    dynamic result = await gradingservice.deleteGrading(
        gradingId, context); // Await deletion

    if (!mounted) return; // Ensure the widget is still mounted

    if (result == "Success") {
      BlocProvider.of<RecentgradingsCubit>(context)
          .deleteItem(index, list, gradingId, context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 18, 189, 2),
        content: Text(
          "Successfully deleted the grading with ID: $gradingId",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    } else {
      // Handle errors appropriately
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error deleting grading: ${result.toString()}",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    }
  }
}
