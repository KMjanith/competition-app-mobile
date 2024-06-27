import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:competition_app/model/Grading.dart';
import 'package:competition_app/pages/grading/PastGradings.dart';
import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/cubit/recentgradings_cubit.dart';
import '../../blocs/cubit/update_grading_students_cubit.dart';
import '../../components/buttons/CreateGradingButton.dart';
import '../../components/common/HedingAnimation.dart';
import 'AddNewGradingetails.dart';

// ignore: must_be_immutable
class NewGrading extends StatefulWidget {
  NewGrading({super.key});

  @override
  State<NewGrading> createState() => _NewGradingState();
}

class _NewGradingState extends State<NewGrading> {
  @override
  void initState() {
    super.initState();
    // Use a post-frame callback to ensure the context is properly initialized.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<RecentgradingsCubit>(context).loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gradingService = Gradingservice();
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
                const HeadingAnimation(heading: "New Grading"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //create a new Grading
                    CreateGradingButon(
                        createGrading: () =>
                            gradingService.createNewGradingPopUp(context),
                        buttonTitle: 'CREATE GRADING'),

                    //Past Grading
                    CreateGradingButon(
                        createGrading: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const Pastgradings())),
                        buttonTitle: 'PAST GRADINGS'),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Next Grading",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 450,
                    child: BlocBuilder<RecentgradingsCubit, List<Grading>>(
                      builder: (context, state) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              var today = DateTime.now();
                              var gradingDate =
                                  DateTime.parse(state[index].gradingTime);
                              if (gradingDate.isAfter(today)) {
                                //loading exiting student list to the BlocProvider
                                BlocProvider.of<UpdateGradingStudentsCubit>(
                                        context)
                                    .addInitialStudent(
                                        state[index].gradingStudentDetails);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: StyleConstants.cardBackGround,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    height: 75,
                                    child: ListTile(
                                      onTap: () {
                                        //navigate to the grading details page

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        Addnewgradingetails(
                                                          grading: state[index],
                                                          gradingstudentdetails:
                                                              state[index]
                                                                  .gradingStudentDetails,
                                                        )));
                                      },
                                      trailing: const Icon(Icons.menu),
                                      leading: const Icon(
                                          Icons.account_tree_rounded),
                                      tileColor: const Color.fromARGB(
                                          255, 12, 110, 160),
                                      title: Text(
                                        state[index].gradingPlace,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      subtitle: Text(state[index].gradingTime),
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox
                                    .shrink(); // Return an empty container to avoid null
                              }
                            });
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
}
