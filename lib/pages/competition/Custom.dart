import 'package:flutter/material.dart';
import '../../components/Constants/StyleConstants.dart';
import '../../components/buttons/CreateGradingButon.dart';
import '../../components/common/HedingAnimation.dart';
import '../../services/CompetitionService.dart';


class CustomMeet extends StatefulWidget {
  final String headingTitle;
  const CustomMeet({super.key, required this.headingTitle});

  @override
  State<CustomMeet> createState() => _CustomMeetState();
}

class _CustomMeetState extends State<CustomMeet> {
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
                          final competitionService = CompetitionService();
                          competitionService.createNewCompetitionPopUp(context,"Custom");
                        },
                        buttonTitle: 'CREATE MEET'),

                    //Past Grading
                    CreateWhiteButon(
                        callback: () {}, buttonTitle: 'PAST MEETS'),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Future custom Meets",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //     ),
                //     height: 450,
                //     child: BlocBuilder<RecentgradingsCubit,
                //         RecentgradingsCubitState>(
                //       builder: (context, state) {
                //         if (state is RecentgradingsLoading) {
                //           return const Center(
                //               child: CircularProgressIndicator());
                //         } else if (state is RecentgradingsLoaded) {
                //           return ListView.builder(
                //               padding: EdgeInsets.zero,
                //               itemCount: state.grading.length,
                //               itemBuilder: (context, index) {
                //                 var today = DateTime.now();
                //                 var gradingDate = DateTime.parse(
                //                     state.grading[index].gradingTime);
                //                 var x = 0;
                //                 if (gradingDate.isAfter(today)) {
                //                   x = 1;
                //                   return Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                           //color: Color.fromARGB(221, 255, 255, 255),
                //                           gradient:
                //                               StyleConstants.cardBackGround,
                //                           borderRadius:
                //                               BorderRadius.circular(16)),
                //                       height: 75,
                //                       child: Slidable(
                //                         // Specify a key if the Slidable is dismissible.
                //                         key: const ValueKey(0),

                //                         // The start action pane is the one at the left or the top side.
                //                         endActionPane: ActionPane(
                //                           // A motion is a widget used to control how the pane animates.
                //                           motion: const ScrollMotion(),

                //                           // A pane can dismiss the Slidable.
                //                           dismissible: DismissiblePane(
                //                               onDismissed: () {}),

                //                           // All actions are defined in the children parameter.
                //                           children: [
                //                             // A SlidableAction can have an icon and/or a label.
                //                             SlidableAction(
                //                               onPressed: (context) => {
                //                                 doNothing(
                //                                     context,
                //                                     state.grading[index].id,
                //                                     index,
                //                                     state.grading)
                //                               },
                //                               backgroundColor:
                //                                   const Color(0xFFFE4A49),
                //                               foregroundColor: Colors.white,
                //                               icon: Icons.delete,
                //                               label: 'Delete',
                //                               borderRadius:
                //                                   BorderRadius.circular(12),
                //                             ),
                //                           ],
                //                         ),

                //                         child: ListTile(
                //                           onTap: () {
                //                             //navigate to the grading details page
                //                             //loading exiting student list to the BlocProvider
                //                             BlocProvider.of<
                //                                         UpdateGradingStudentsCubit>(
                //                                     context)
                //                                 .addInitialStudent(state
                //                                     .grading[index]
                //                                     .gradingStudentDetails);

                //                             Navigator.of(context).push(
                //                                 MaterialPageRoute(
                //                                     builder: (context) =>
                //                                         AddNewStudent(
                //                                           grading: state
                //                                               .grading[index],
                //                                           gradingstudentdetails:
                //                                               state
                //                                                   .grading[
                //                                                       index]
                //                                                   .gradingStudentDetails,
                //                                         )));
                //                           },
                //                           trailing: const Icon(Icons.menu),
                //                           leading: const Icon(
                //                               Icons.account_tree_rounded),
                //                           tileColor: const Color.fromARGB(
                //                               255, 12, 110, 160),
                //                           title: Text(
                //                             state.grading[index].gradingPlace,
                //                             style:
                //                                 const TextStyle(fontSize: 20),
                //                           ),
                //                           subtitle: Text(
                //                               state.grading[index].gradingTime),
                //                         ),
                //                       ),
                //                     ),
                //                   );
                //                 } else if (x == 0) {
                //                   return const NothingWidget(
                //                       content: "No Recent Grading found",
                //                       icon: Icons.error);
                //                 }
                //                 return const SizedBox
                //                     .shrink(); // Return an empty container to avoid null
                //               });
                //         }
                //         return const SizedBox.shrink();
                //       },
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //void doNothing(BuildContext context, String gradingId, int index,
  //     List<Grading> list) async {
  //   final Gradingservice gradingservice = Gradingservice();
  //   BlocProvider.of<RecentgradingsCubit>(context)
  //       .deleteItem(index, list, gradingId, context);
  //   dynamic result = await gradingservice.deleteGrading(
  //       gradingId, context); // Await deletion

  //   if (!mounted) return; // Ensure the widget is still mounted

  //   if (result == "Success") {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       backgroundColor: const Color.fromARGB(255, 18, 189, 2),
  //       content: Text(
  //         "Successfully deleted the grading with ID: $gradingId",
  //         style: const TextStyle(fontSize: 20),
  //       ),
  //     ));
  //   } else {
  //     // Handle errors appropriately
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       backgroundColor: const Color.fromARGB(255, 189, 2, 2),
  //       content: Text(
  //         "Error deleting grading: ${result.toString()}",
  //         style: const TextStyle(fontSize: 20),
  //       ),
  //     ));
  //   }
  // }
}
