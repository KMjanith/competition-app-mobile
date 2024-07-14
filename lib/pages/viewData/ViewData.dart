import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/view_data_cubit.dart';
import '../../components/common/CustomDrawer.dart';
import '../../cubit/ErrorAlert.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../Constants/StyleConstants.dart';
import '../../services/ViewStudent.dart';

class Viewdata extends StatefulWidget {
  @override
  _ViewdataState createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  @override
  void initState() {
    super.initState();
    context.read<ViewStudentDataCubit>().loadStudents(context);
  }

  CustomDrawer _returnDrawer(BuildContext context) {
    final indexInputController = TextEditingController();
    return CustomDrawer(
      drawerItems: [
        ListTile(
          title: const Text('Index No'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Color.fromARGB(179, 216, 216, 216),
                  title: const Text("Add index number"),
                  actions: [
                    InputField(
                      controller: indexInputController,
                      keyboardType: TextInputType.number,
                      labelText: "Index No",
                    ),
                    TextButton(
                      onPressed: () {
                        final viewStudent =
                            BlocProvider.of<ViewStudentDataCubit>(context)
                                .getStudents();
                        final viewStudentService = Viewstudent();

                        final indexNo = indexInputController.text;
                        final student = viewStudent.firstWhere(
                          (student) => student['indexNo'] == indexNo,
                          orElse: () => {},
                        );

                        if (student.isNotEmpty) {
                          viewStudentService.showStudentDialog(
                              student, context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorAlert(
                                  description: "Student not found");
                            },
                          );
                        }
                      },
                      child: const Text("Filter by index"),
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _returnDrawer(context),
      body: Stack(children: [
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
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
            const HeadingAnimation(heading: "Student data"),
            Expanded(
              child: BlocBuilder<ViewStudentDataCubit, ViewStudentDataState>(
                builder: (context, state) {
                  if (state is ViewDataStudentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ViewDataStudentsLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.students.length,
                      itemBuilder: (context, index) {
                        var student = state.students[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              final viewStudentService = Viewstudent();
                              viewStudentService.showStudentDialog(
                                  student, context);
                            },
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                dismissible:
                                    DismissiblePane(onDismissed: () {}),
                                children: [
                                  SlidableAction(
                                    padding: const EdgeInsets.all(5),
                                    onPressed: (context) => {
                                      
                                      context
                                          .read<ViewStudentDataCubit>()
                                          .deleteStudent(student['indexNo'],
                                              context, state.students, index),
                                      if (state is ViewDataDeletingLoading)
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const ErrorAlert(
                                                  description:
                                                      "Deleting student");
                                            },
                                          )
                                        }
                                      else
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text("Success"),
                                                content: const Text(
                                                    "Student deleted successfully"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("OK"),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        }
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: StyleConstants.cardBackGround,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Name: ${student['firstName']} ${student['lastName']}",
                                              style: GoogleFonts.radioCanada(
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Index No: ${student['indexNo']}',
                                              style: GoogleFonts.radioCanada(
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipOval(
                                        child: Container(
                                          height: 75,
                                          width: 75,
                                          color: Colors.black,
                                          child: student['photoUrl'] != null &&
                                                  student['photoUrl'].isNotEmpty
                                              ? Image.network(
                                                  student['photoUrl'],
                                                  fit: BoxFit.cover,
                                                )
                                              : const Icon(Icons.person,
                                                  size: 50,
                                                  color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ViewDataStudentsError) {
                    return const Center(
                      child: Text("something"),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
