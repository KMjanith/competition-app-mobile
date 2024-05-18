import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  final Function sectDate;
  final TextEditingController dateController;
  const DatePickerInput({super.key, required this.sectDate, required this.dateController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: dateController, // Use controller to display selected date
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          prefixIcon: Icon(Icons.calendar_today),
          labelText: "Date of Birth",
          hintText: "Select Date",
        ),
        readOnly: true,
        onTap: () {
          sectDate();
        },
      ),
    );
  }
}
