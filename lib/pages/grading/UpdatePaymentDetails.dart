import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/Constants/AppConstants.dart';
import '../../components/Constants/StyleConstants.dart';
import '../../cubit/update_grading_students_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/DatePickerInput.dart';
import '../../components/inputs/DropDownInput.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/GradingStudentDetals.dart';
import '../../services/Validator.dart';

class UpdatePaymentDetails extends StatefulWidget {
  final String gradingId;
  final int index;
  final List<Gradingstudentdetails> gradingstudentdetails;
  const UpdatePaymentDetails(
      {super.key,
      required this.gradingstudentdetails,
      required this.index,
      required this.gradingId});

  @override
  State<UpdatePaymentDetails> createState() => _GradingstudentState();
}

class _GradingstudentState extends State<UpdatePaymentDetails> {
  final payAmount = TextEditingController();
  final description = TextEditingController();
  final datePaid = TextEditingController();
  DateTime? dates;
  String? selectedPaymentStatus;
  final Gradingservice gradingservice = Gradingservice();

  Future<void> _selectDate() async {
    dates = await showDatePicker(
        context: context, firstDate: DateTime(1999), lastDate: DateTime(2100));
    datePaid.text = dates.toString().split(" ")[0];
  }

  void _updateStudent(BuildContext context) {
    Gradingstudentdetails student = widget.gradingstudentdetails[widget.index];
    student.gradingFees = payAmount.text;
    student.paidDate = datePaid.text;
    student.paymentStatus = selectedPaymentStatus ?? student.paymentStatus;

    final allset = Validator.gradingStudentPaymentDetailsValidator(student);

    if (allset == true) {
      gradingservice.updateGradingStudentDetails(
          widget.gradingId,
          widget.gradingstudentdetails,
          context,
          "Payment details updated successfully",
          "Failed to update payment details");
      //updating the ui
      BlocProvider.of<UpdateGradingStudentsCubit>(context)
          .updateStudents(widget.gradingstudentdetails);

      payAmount.clear();
      datePaid.clear();
      description.clear();
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
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          //StyleConstants.lowerBackgroundContainer,
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
                const HeadingAnimation(heading: "Student's Details"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 15, bottom: 1),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 1, 70, 77),
                              Color.fromARGB(255, 0, 64, 68),
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Column(
                            children: [
                              textingDetails(
                                  "S.No:  ",
                                  widget
                                      .gradingstudentdetails[widget.index].sNo),
                              textingDetails(
                                  "Full Name:  ",
                                  widget.gradingstudentdetails[widget.index]
                                      .fullName),
                              textingDetails(
                                  "Current KYU:  ",
                                  widget.gradingstudentdetails[widget.index]
                                      .currentKyu),
                              textingDetails(
                                  "Payment status:  ",
                                  widget.gradingstudentdetails[widget.index]
                                      .paymentStatus),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Update Payment status",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    InputField(
                        labelText: "amount",
                        controller: payAmount,
                        keyboardType: TextInputType.number),
                    DatePickerInput(
                      dateController: datePaid,
                      labelName: "Date",
                      selectedDate: _selectDate,
                    ),
                    DropDownInput(
                      itemList: AppConstants.paymentStatus,
                      title: "Payment Status",
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentStatus = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
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
                                  _updateStudent(context);
                                },
                                child: const Text(
                                  "Update",
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
                              onPressed: () {},
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Padding textingDetails(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 30, top: 5, bottom: 5),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: const Color.fromARGB(255, 235, 235, 235),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            textAlign: TextAlign.left,
            value,
            style: GoogleFonts.anta(
              fontSize: 18,
              color: const Color.fromARGB(255, 231, 231, 231),
            ),
            overflow: TextOverflow.ellipsis, // Adds ellipsis if text overflows
          ),
        ),
      ],
    ),
  );
}
