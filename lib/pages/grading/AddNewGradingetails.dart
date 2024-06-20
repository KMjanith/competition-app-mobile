import 'package:competition_app/model/GradingStudentDetals.dart';
import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Constants/StyleConstants.dart';
import '../../blocs/cubit/update_grading_students_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/Grading.dart';

class Addnewgradingetails extends StatefulWidget {
  final Grading grading;
  const Addnewgradingetails({super.key, required this.grading});

  @override
  State<Addnewgradingetails> createState() => _AddnewgradingetailsState();
}

class _AddnewgradingetailsState extends State<Addnewgradingetails> {
  late TextEditingController studentNameController;
  late TextEditingController sNoController;
  late TextEditingController currentKyuController;

  @override
  void initState() {
    super.initState();
    studentNameController = TextEditingController();
    sNoController = TextEditingController();
    currentKyuController = TextEditingController();
  }

  @override
  void dispose() {
    studentNameController.dispose();
    sNoController.dispose();
    currentKyuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      icon: const Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "Add Grading Details"),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(66, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        'Place is:  ${widget.grading.gradingPlace}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('Date is:  ${widget.grading.gradingTime.toString()}')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 23),
                    child: Text("Add Students here"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InputField(
                          labelText: "S.No",
                          controller: sNoController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Expanded(
                        child: InputField(
                          labelText: "Current Kyu",
                          controller: currentKyuController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                  InputField(
                    controller: studentNameController,
                    keyboardType: TextInputType.text,
                    labelText: "Full Name",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 19, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: StyleConstants.submitButtonColor,
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                            ),
                            width: 300,
                            height: 60,
                            child: TextButton(
                              onPressed: () {
                                final gradingService = Gradingservice();
                                gradingService.addStudent(
                                  context,
                                  sNoController.text,
                                  studentNameController.text,
                                  currentKyuController.text,
                                  widget.grading,
                                );
                                studentNameController.clear();
                                sNoController.clear();
                                currentKyuController.clear();
                              },
                              child: const Text(
                                "Add Student",
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 19),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: StyleConstants.cancelButtonColor,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                          ),
                          width: 100,
                          height: 60,
                          child: TextButton(
                            onPressed: () {
                              studentNameController.clear();
                              sNoController.clear();
                              currentKyuController.clear();
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // UI part to display the students
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: BlocBuilder<UpdateGradingStudentsCubit, List<Gradingstudentdetails>>(
                      builder: (context, state) {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  //gradient: StyleConstants.cardBackGround,
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                height: 75,
                                child: ListTile(
                                  onTap: () {
                                    print(state);
                                  },
                                  trailing: const Icon(
                                    Icons.menu,
                                   
                                  ),
                                  leading: const Icon(
                                    Icons.account_tree_rounded,
                                    color: Color.fromARGB(255, 167, 125, 0),
                                  ),
                                  title: Text(
                                    '${state[index].sNo} . ${state[index].FullName}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      
                                    ),
                                  ),
                                  subtitle: Text(
                                    'current - ${state[index].currentKyu}kyu',
                                    style: const TextStyle(
                                      fontSize: 16,
                                     
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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
