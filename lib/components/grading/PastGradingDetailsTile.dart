import 'package:competition_app/Constants/PaymentStatus.dart';
import 'package:competition_app/model/GradingStudentDetals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../inputs/Inputs.dart';

class PastGradingDetailsTile extends StatelessWidget {
  final Gradingstudentdetails gradingStudent;
  const PastGradingDetailsTile({super.key, required this.gradingStudent});

  @override
  Widget build(BuildContext context) {
    final String gradingFees;
    final String paidDate;
    final Color backColor;
    final Color frontColor;

    if (gradingStudent.paymentStatus != PaymentStatus.pending) {
      gradingFees = "Not Paid";
      paidDate = "Not Paid";
      backColor = const Color.fromARGB(255, 165, 255, 168);
      frontColor = Color.fromARGB(192, 102, 245, 107);
    } else {
      gradingFees = gradingStudent.gradingFees;
      paidDate = gradingStudent.paidDate;
      backColor = Color.fromARGB(255, 255, 172, 166);
      frontColor = Color.fromARGB(204, 247, 129, 121);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(167, 0, 0, 0),
                blurRadius: 5,
                spreadRadius: 0.5,
                offset: Offset(1, 2))
          ],
          color: backColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 100,
                width: 250,
                decoration: BoxDecoration(
                    color: frontColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(55),
                        bottomRight: Radius.circular(55))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textingDetails("S.No", gradingStudent.sNo),
                        textingDetails("Full Name", gradingStudent.fullName),
                        textingDetails("Past Kyu", gradingStudent.currentKyu),
                        textingDetails("Grading Fees", gradingFees),
                        textingDetails("Paid Date", paidDate),
                        textingDetails("Passed Kyu", gradingStudent.passedKyu)
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 0, 106, 133)),
                              child: TextButton(
                                  onPressed: () {
                                    changeGradingResults(
                                        context,
                                        gradingStudent,
                                        frontColor,
                                        gradingStudent);
                                  },
                                  child: const Text(
                                    "Edit results",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Icon(Icons.sports_martial_arts,
                                size: 50, color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void changeGradingResults(BuildContext context, Gradingstudentdetails student,
    Color frontColor, Gradingstudentdetails studentDetail) {
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
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
        );
      });
}

Padding textingDetails(String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 20, top: 5, bottom: 5),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Icon(Icons.arrow_right, color: Colors.black, size: 15),
              const SizedBox(
                width: 3,
              ),
              Text(
                key,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 1,
          child: Text(
            textAlign: TextAlign.left,
            value,
            style: GoogleFonts.anta(
              fontSize: 12,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            overflow: TextOverflow.ellipsis, // Adds ellipsis if text overflows
          ),
        ),
      ],
    ),
  );
}
