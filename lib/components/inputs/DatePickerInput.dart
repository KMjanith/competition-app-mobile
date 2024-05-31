import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  final Function selectedDate;
  final TextEditingController dateController;
  const DatePickerInput({super.key, required this.selectedDate, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: BorderSide.strokeAlignCenter, left: 28, right: 28),
      child: TextField(
        controller: dateController, // Use controller to display selected date
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: Icon(Icons.calendar_today, color: Color.fromARGB(255, 150, 150, 150)),
          labelText: "Date of Birth",
          labelStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          hintText: "Select Date",
        ),
        readOnly: true,
        onTap: () {
          selectedDate();
        },
      ),
    );
  }
}
