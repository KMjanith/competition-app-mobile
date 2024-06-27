import 'package:competition_app/services/GradingService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/AppConstants.dart';
import '../../Constants/StyleConstants.dart';
import '../../blocs/cubit/update_grading_students_cubit.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/DatePickerInput.dart';
import '../../components/inputs/DropDownInput.dart';
import '../../components/inputs/Inputs.dart';
import '../../model/GradingStudentDetals.dart';

class GradingPayments extends StatefulWidget {
  final String gradingId;
  final int index;
  final List<Gradingstudentdetails> gradingstudentdetails;
  const GradingPayments(
      {super.key,
      required this.gradingstudentdetails,
      required this.index,
      required this.gradingId});

  @override
  State<GradingPayments> createState() => _GradingstudentState();
}

class _GradingstudentState extends State<GradingPayments> {
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
                              Color.fromARGB(255, 235, 154, 32),
                              Color.fromARGB(255, 238, 39, 39),
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
                        keyboardType: TextInputType.text),
                    DatePickerInput(
                      dateController: datePaid,
                      lableName: "Date",
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
                              height: 60,
                              child: TextButton(
                                onPressed: () {
                                  widget.gradingstudentdetails[widget.index]
                                      .gradingFees = payAmount.text;
                                  widget.gradingstudentdetails[widget.index]
                                      .paidDate = datePaid.text;
                                  widget.gradingstudentdetails[widget.index]
                                      .paymentStatus = selectedPaymentStatus!;

                                  gradingservice.updatePaymentStatus(
                                    widget.gradingId,
                                    widget.gradingstudentdetails,
                                    context,
                                  );
                                  //updating the ui
                                  BlocProvider.of<UpdateGradingStudentsCubit>(
                                          context)
                                      .updatedPaymentDetails(context,
                                          widget.gradingstudentdetails);

                                  payAmount.clear();
                                  datePaid.clear();
                                  description.clear();
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
                            height: 60,
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
