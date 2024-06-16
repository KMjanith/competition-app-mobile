import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  final Function selectedDate;
  final TextEditingController dateController;
  final String lableName;
  const DatePickerInput(
      {super.key, required this.selectedDate, required this.dateController, required this.lableName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 8.0, bottom: BorderSide.strokeAlignCenter, left: 20, right: 20),
      child: TextField(
        controller: dateController, // Use controller to display selected date
        decoration:  InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: const Icon(Icons.calendar_today,
              color: Color.fromARGB(255, 150, 150, 150)),
          labelText: lableName,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
