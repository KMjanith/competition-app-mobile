import 'package:competition_app/Constants/PaymentStatus.dart';
import 'package:competition_app/blocs/cubit/recentgradings_cubit.dart';
import 'package:competition_app/model/GradingStudentDetals.dart';
import 'package:competition_app/pages/grading/GradingPayments.dart';
import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/StyleConstants.dart';
import '../../blocs/cubit/db_cubit.dart';
import '../../blocs/cubit/update_grading_students_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/Grading.dart';
import '../../services/Validator.dart';

class Addnewgradingetails extends StatefulWidget {
  final Grading grading;
  final List<Gradingstudentdetails> gradingstudentdetails;
  const Addnewgradingetails(
      {super.key, required this.grading, required this.gradingstudentdetails});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<UpdateGradingStudentsCubit>(context)
          .addInitialStudent(widget.grading.gradingStudentDetails);
    });
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
                const HeadingAnimation(heading: "Add Grading Details"),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 23),
                      child: Center(
                        child: Text(
                          "Add Students here",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InputField(
                            labelText: "S.No",
                            controller: sNoController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Expanded(
                          child: InputField(
                            labelText: "Current Kyu",
                            controller: currentKyuController,
                            keyboardType: TextInputType.number,
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
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 19, right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: StyleConstants.submitButtonColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                              ),
                              width: 300,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  addTheNewStudent();
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
                                  const BorderRadius.all(Radius.circular(16)),
                            ),
                            width: 100,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                studentNameController.clear();
                                sNoController.clear();
                                currentKyuController.clear();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Current Registered Students",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 20, 20, 20))),
                // UI part to display the students
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 450,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: BlocBuilder<UpdateGradingStudentsCubit,
                          List<Gradingstudentdetails>>(
                        builder: (context, state) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.length,
                            itemBuilder: (context, index) {
                              bool colorBool =
                                  state[index].paymentStatus.trim() ==
                                      PaymentStatus.pending;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: colorBool
                                        ? StyleConstants.falseTileBackground
                                        : StyleConstants.trueTileBackground,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(55, 0, 0, 0),
                                        offset: Offset(1, 4),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  height: 75,
                                  child: Slidable(
                                    // Specify a key if the Slidable is dismissible.
                                    key: const ValueKey(0),

                                    // The start action pane is the one at the left or the top side.
                                    endActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      dismissible: DismissiblePane(
                                          onDismissed: () {},
                                          dismissThreshold:
                                              0.5 // Adjust the threshold here
                                          ),

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) {
                                            doNothing(state[index], state,
                                                widget.grading.id, context);

                                            BlocProvider.of<
                                                        UpdateGradingStudentsCubit>(
                                                    context)
                                                .updateStudents(state);
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
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
                                        //addPaymentDetails();

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GradingPayments(
                                              gradingstudentdetails: state,
                                              index: index,
                                              gradingId: widget.grading.id,
                                            ),
                                          ),
                                        );
                                      },
                                      trailing: const Icon(
                                        Icons.menu,
                                      ),
                                      leading: const Icon(
                                        Icons.account_tree_rounded,
                                        color: Color.fromARGB(255, 167, 125, 0),
                                      ),
                                      title: Text(
                                        '${state[index].sNo} . ${state[index].fullName}',
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
        ],
      ),
    );
  }

  void doNothing(
      Gradingstudentdetails itemToRemove,
      List<Gradingstudentdetails> currentList,
      String gradingId,
      BuildContext context) async {
    final gradingservice = Gradingservice();
    final db = BlocProvider.of<DbCubit>(context).firestore;
    widget.grading.gradingStudentDetails.remove(itemToRemove);
    context
        .read<RecentgradingsCubit>()
        .updateGradingList(widget.grading, widget.grading.id);
    final result = await gradingservice.deleteStudentFromGrading(
        gradingId, db, currentList, itemToRemove, context);

    //BlocProvider.of<RecentgradingsCubit>(context).loadData(context);

    if (!mounted) return; // Ensure the widget is still mounted
    if (result == 'Success') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 18, 189, 2),
        content: Text(
          "Successfully deleted the student : ${itemToRemove.fullName}",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    } else {
      // Handle errors appropriately
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        content: Text(
          "Error deleting student: $result",
          style: const TextStyle(fontSize: 20),
        ),
      ));
    }
  }

  void addTheNewStudent() {
    final gradingService = Gradingservice();
    final student = Gradingstudentdetails(
      sNo: sNoController.text,
      fullName: studentNameController.text,
      currentKyu: currentKyuController.text,
      paymentStatus: PaymentStatus.pending,
      gradingFees: '',
      paidDate: '',
      passedKyu: 'Pending'
    );

    final allset = Validator.gradingStudentValidator(student);

    if (allset == true) {
      // Add the student to the grading
      gradingService.addStudent(student, context, widget.grading);
      context.read<UpdateGradingStudentsCubit>().addStudents(student, context);
      widget.grading.gradingStudentDetails.add(student);
      context
          .read<RecentgradingsCubit>()
          .updateGradingList(widget.grading, widget.grading.id);

      // Clear input fields after successful addition
      studentNameController.clear();
      sNoController.clear();
      currentKyuController.clear();
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
}
