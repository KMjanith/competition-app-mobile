import 'package:flutter/material.dart';

class DatePickerInput extends StatelessWidget {
  final Function() selectedDate; // Updated to use void return type for the function
  final TextEditingController dateController;
  final String labelName;

  const DatePickerInput({
    Key? key,
    required this.selectedDate,
    required this.dateController,
    required this.labelName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20, right: 20),
      child: TextFormField(
        controller: dateController,
        decoration: InputDecoration(
          fillColor: Color.fromARGB(64, 139, 139, 139),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.white),
          labelText: labelName,
          labelStyle: const TextStyle(color: Colors.white),
        ),
        readOnly: true,
        style: const TextStyle(color: Colors.white), // Ensure text color is white
        onTap: () {
          selectedDate();
        },
      ),
    );
  }
}
