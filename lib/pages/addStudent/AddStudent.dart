import 'package:competition_app/components/buttons/CancelButton.dart';
import 'package:competition_app/components/buttons/SubmitButton.dart';
import 'package:competition_app/components/inputs/DatePickerInput.dart';
import 'package:flutter/material.dart';
import '../../components/inputs/DropDownInput.dart';
import '../../components/inputs/Inputs.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = picked
            .toString()
            .split(' ')[0]; // Update controller with selected date
      });
    }
  }

  final List<DropdownMenuItem<String>> grade = [
    const DropdownMenuItem(value: "grade 1", child: Text("grade 1")),
    const DropdownMenuItem(value: "grade 2", child: Text("grade 2")),
    const DropdownMenuItem(value: "grade 3", child: Text("grade 3")),
    const DropdownMenuItem(value: "grade 4", child: Text("grade 4")),
    const DropdownMenuItem(value: "grade 5", child: Text("grade 5")),
    const DropdownMenuItem(value: "grade 6", child: Text("grade 6")),
  ];
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Add Student"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            const Text(
              "Application Form",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //first name and last name input fields
                Expanded(child: InputField(labelText: "First Name")),
                Expanded(child: InputField(labelText: "Last Name")),
              ],
            ),
            const InputField(labelText: "Name with Initials"),
            const InputField(labelText: "Index no:"),
            //grade selector
            DropDownInput(itemList: grade),

            const SizedBox(height: 10),
            const Text(
              "fill by the parent or guardian",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            //birthday picker
            DatePickerInput(
                selectedDate: _selectDate, dateController: _dateController),
            const InputField(
                labelText:
                    "name of the  guardian"), //year that student entered the school
            const InputField(
                labelText:
                    "Entered Year"), //year that student entered the school
            const InputField(
                labelText: "Home Address"), //Home address of the student
            const InputField(
                labelText:
                    "mobile or Tel number"), //year that student entered the school
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubmitButton(),
                SizedBox(width: 10),
                CancelButton(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
