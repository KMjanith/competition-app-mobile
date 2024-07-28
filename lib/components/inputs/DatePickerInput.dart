import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  final Function selectedDate;
  final TextEditingController dateController;
  final String lableName;
  const DatePickerInput(
      {super.key,
      required this.selectedDate,
      required this.dateController,
      required this.lableName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextField(
        controller: dateController, // Use controller to display selected date
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(150, 255, 255, 255),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none, // No border side color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color.fromARGB(0, 0, 0, 0)), // Transparent border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color:
                    Color.fromARGB(255, 255, 255, 255)), // Transparent border
          ),
          prefixIcon: const Icon(Icons.calendar_today,
              color: Color.fromARGB(255, 255, 255, 255)),
          label: Text(
            lableName,
            style: const TextStyle(color: Colors.white),
          ),
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        readOnly: true,
        onTap: () {
          selectedDate();
        },
      ),
    );
  }
}
