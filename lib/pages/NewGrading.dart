import 'package:competition_app/Constants/StyleConstants.dart';
import 'package:competition_app/model/Grading.dart';
import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit/recentgradings_cubit.dart';
import '../components/buttons/CreateGradingButton.dart';
import '../components/common/HedingAnimation.dart';

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
      body: Container(
        decoration: StyleConstants.pageBackground,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
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
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "New Grading"),

              //create a new Grading
              CreateGradingButon(
                  createGrading: () =>
                      gradingService.createNewGradingPopUp(context),
                  buttonTitle: 'CREATE GRADING'),

              //Past Grading
              CreateGradingButon(
                  createGrading: () {}, buttonTitle: 'PAST GRADINGS'),

              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Next Grading", style: TextStyle(fontSize: 20)),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(111, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 350,
                  child: BlocBuilder<RecentgradingsCubit, List<Grading>>(
                    builder: (context, state) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: StyleConstants.cardBackGround,
                                    borderRadius: BorderRadius.circular(16)),
                                height: 75,
                                child: ListTile(
                                  leading: Icon(Icons.account_tree_rounded),
                                  tileColor:
                                      const Color.fromARGB(255, 12, 110, 160),
                                  title: Text(
                                    state[index].gradingPlace,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  subtitle: Text(state[index].gradingTime),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
