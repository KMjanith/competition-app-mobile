import 'package:competition_app/cubit/past_grading_details_cubit.dart';
import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/grading/PastGradingDetailsTile.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/Grading.dart';
import '../../model/GradingStudentDetals.dart';

class PastGradinDetails extends StatelessWidget {
  final Grading grading;
  const PastGradinDetails({super.key, required this.grading});

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
              const HeadingAnimation(heading: "Past Gradings Details"),
              const Text(
                "All student and Grading Details are here",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<PastGradingDetailsCubit,
                    PastGradingDetailsState>(
                  builder: (context, state) {
                    if (state is PastGradingDetailsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PastGradingDetailsLoaded) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.gradingstudentDetails.length,
                        itemBuilder: (context, index) {
                          return PastGradingDetailsTile(
                              gradingStudent:
                                  state.gradingstudentDetails[index],
                              changeGradingResults: (context, student,
                                      frontColor, studentDetail) =>
                                  changeGradingResults(
                                    context,
                                    frontColor,
                                    studentDetail,
                                  ));
                        },
                      );
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

  void changeGradingResults(BuildContext context, Color frontColor,
      Gradingstudentdetails studentDetail) {
    final passedKyu = TextEditingController();
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
                    //Update new result button
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 21, 243, 95),
                    ),
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        studentDetail.passedKyu = passedKyu.text;
                        passedKyu.clear();
                        BlocProvider.of<PastGradingDetailsCubit>(context)
                            .loadData(grading.gradingStudentDetails);
                        final gradingService = Gradingservice();
                        gradingService.updateGradingStudentDetails(
                            grading.id,
                            grading.gradingStudentDetails,
                            context,
                            "Updated New Results",
                            "Failed to Update New Results");
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Color.fromARGB(255, 7, 0, 39)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            backgroundColor: const Color.fromARGB(255, 238, 238, 238),
            title: const Text("Update grading Results"),
            icon: const Icon(Icons.update_rounded),
            shadowColor: Colors.black,
            surfaceTintColor: frontColor,
            content: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text(
                      "Enter Kyu",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  InputField(
                    labelText: "New Kyu",
                    controller: passedKyu,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
