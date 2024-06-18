import 'package:competition_app/model/GradingStudentDetals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/StyleConstants.dart';
import '../../blocs/cubit/update_grading_students_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/Grading.dart';
import '../../services/Validator.dart';

class Addnewgradingetails extends StatefulWidget {
  final Grading grading;
  const Addnewgradingetails({super.key, required this.grading});

  @override
  State<Addnewgradingetails> createState() => _AddnewgradingetailsState();
}

class _AddnewgradingetailsState extends State<Addnewgradingetails> {
  late TextEditingController studentNameController;
  late TextEditingController sNoController;
  late TextEditingController currentKyuCOntroller;

  @override
  void initState() {
    super.initState();
    studentNameController = TextEditingController();
    sNoController = TextEditingController();
    currentKyuCOntroller = TextEditingController();
  }

  void addStudent(BuildContext context) {
    final student = Gradingstudentdetails(
        sNo: sNoController.text,
        FullName: studentNameController.text,
        currentKyu: currentKyuCOntroller.text);

    //form validator
    final allset = Validator.gradingStudentValidator(student);

    if (allset == true) {
      //updating the ui
      BlocProvider.of<UpdateGradingStudentsCubit>(context)
          .addStudents(student, context);

      studentNameController.clear();
      sNoController.clear();
      currentKyuCOntroller.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 165, 5, 2),
          content: Text(
            allset,
            style: GoogleFonts.alegreya(fontSize: 20),
          ),
        ),
      );
    }
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
                      icon: const Icon(Icons.menu,
                          color: Color.fromARGB(255, 0, 0, 0)),
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
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Text("Add Students here"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: InputField(
                              labelText: "S.No",
                              controller: sNoController,
                              keyboardType: TextInputType.text)),
                      Expanded(
                          child: InputField(
                              labelText: "current Kyu",
                              controller: currentKyuCOntroller,
                              keyboardType: TextInputType.text)),
                    ],
                  ),
                  InputField(
                      controller: studentNameController,
                      keyboardType: TextInputType.text,
                      labelText: "Full Name"),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 19, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: StyleConstants.submitButtonColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16))),
                            width: 300,
                            height: 60,
                            child: TextButton(
                              onPressed: () {
                                addStudent(context);
                              },
                              child: const Text(
                                "Add Student",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 19),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: StyleConstants.cancelButtonColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16))),
                          width: 100,
                          height: 60,
                          child: TextButton(
                            onPressed: () {
                              studentNameController.clear();
                              sNoController.clear();
                              currentKyuCOntroller.clear();
                            },
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              //ui part to display the students
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 450,
                  child: BlocBuilder<UpdateGradingStudentsCubit,
                      List<Gradingstudentdetails>>(
                    builder: (context, state) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      gradient: StyleConstants.cardBackGround,
                                      borderRadius: BorderRadius.circular(16)),
                                  height: 75,
                                  child: ListTile(
                                    onTap: () {
                                      print(state);
                                    },
                                    trailing: const Icon(
                                      Icons.menu,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    leading: const Icon(
                                      Icons.account_tree_rounded,
                                      color: Color.fromARGB(255, 167, 125, 0),
                                    ),
                                    title: Text(
                                      '${state[index].sNo} . ${state[index].FullName}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 236, 236, 236)),
                                    ),
                                    subtitle: Text(
                                      'current - ${state[index].currentKyu}kyu ',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 240, 240, 240)),
                                    ),
                                  ),
                                ),
                              );
                            }
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
