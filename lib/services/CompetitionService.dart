import 'package:flutter/material.dart';


import '../components/inputs/DatePickerInput.dart';
import '../components/inputs/DropDownInput.dart';
import '../components/inputs/Inputs.dart';

class CompetitionService {
  void createNewGradingPopUp(BuildContext context) {
    final TextEditingController meetTimeController = TextEditingController();
    final TextEditingController meetPlaceController = TextEditingController();

    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        meetTimeController.text = picked.toString().split(' ')[0];
      }
    }

    String? selectedGrade;

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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 21, 243, 95),
                  ),
                  width: 100,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Create",
                      style: TextStyle(color: Color.fromARGB(255, 7, 0, 39)),
                    ),
                  ),
                ),
              ],
            ),
          ],
          backgroundColor: Color.fromARGB(255, 232, 233, 233),
          title: const Text("Create New Meet"),
          surfaceTintColor: Color.fromARGB(255, 140, 248, 252),
          content: Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                DatePickerInput(
                  dateController: meetTimeController,
                  selectedDate: _selectDate,
                  lableName: "Date",
                ),
                InputField(
                  labelText: "Meet Place",
                  controller: meetPlaceController,
                  keyboardType: TextInputType.text,
                ),
                DropDownInput(
                  onChanged: (value) {
                    selectedGrade = value;
                    
                  },
                  title: "Competition Type",
                  itemList: ["Provincial", "National"]
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                ),
                if(selectedGrade == "Provincial")
                DropDownInput(
                  onChanged: (value) {
                    selectedGrade = value;
                    
                  },
                  title: "Competition Type",
                  itemList: ["Provincial", "National"]
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
