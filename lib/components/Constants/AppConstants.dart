import 'package:competition_app/components/Constants/PaymentStatus.dart';
import 'package:flutter/material.dart';

class AppConstants {
  // Prevent instantiation of the class
  AppConstants._();

  static const List<DropdownMenuItem<String>> grade = [
    DropdownMenuItem(value: "grade 1", child: Text("grade 1")),
    DropdownMenuItem(value: "grade 2", child: Text("grade 2")),
    DropdownMenuItem(value: "grade 3", child: Text("grade 3")),
    DropdownMenuItem(value: "grade 4", child: Text("grade 4")),
    DropdownMenuItem(value: "grade 5", child: Text("grade 5")),
    DropdownMenuItem(value: "grade 6", child: Text("grade 6")),
    DropdownMenuItem(value: "grade 7", child: Text("grade 7")),
    DropdownMenuItem(value: "grade 8", child: Text("grade 8")),
    DropdownMenuItem(value: "grade 9", child: Text("grade 9")),
    DropdownMenuItem(value: "grade 10", child: Text("grade 10")),
    DropdownMenuItem(value: "grade 11", child: Text("grade 11")),
    DropdownMenuItem(value: "grade 12", child: Text("grade 12")),
    DropdownMenuItem(value: "grade 13", child: Text("grade 13")),
  ];

  static const List<DropdownMenuItem<String>> paymentStatus = [
    DropdownMenuItem(
        value: PaymentStatus.pending, child: Text(PaymentStatus.pending)),
    DropdownMenuItem(
        value: PaymentStatus.paidHandOver,
        child: Text(PaymentStatus.paidHandOver)),
    DropdownMenuItem(
        value: PaymentStatus.paidWithBankSlip,
        child: Text(PaymentStatus.paidWithBankSlip)),
  ];

  static const List<String> provincesOfSriLanka = [
    "All Island",
    "Central Prov",
    "Eastern Prov",
    "Northern Prov",
    "North Central Prov",
    "North Western Prov",
    "Sabaragamuwa Prov",
    "Southern Prov",
    "Uva Prov",
    "Western Prov"
  ];

  static const List<String> levels = [
    "Lv.1",
    "Lv.2",
    "Lv.3",
    "Lv.4",
    "Lv.5",
  ];

  static const List<String> catagories = [
    "Junior",
    "Cadet",
    "Sub Junior",
    "Senior",
  ];
}
