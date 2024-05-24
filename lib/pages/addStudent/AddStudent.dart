import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/components/dataRepo/AppConstants.dart';
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
  late TextEditingController firstName;
  late TextEditingController lastName;
  late TextEditingController nameWithInitials;
  late TextEditingController indexNo;
  late TextEditingController birthDay;
  late TextEditingController guardianName;
  late TextEditingController enteredYear;
  late TextEditingController homeAddress;
  late TextEditingController mobileNumber;
  String? selectedGrade;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    firstName = TextEditingController();
    lastName = TextEditingController();
    nameWithInitials = TextEditingController();
    indexNo = TextEditingController();
    birthDay = TextEditingController();
    guardianName = TextEditingController();
    enteredYear = TextEditingController();
    homeAddress = TextEditingController();
    mobileNumber = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    firstName.dispose();
    lastName.dispose();
    nameWithInitials.dispose();
    indexNo.dispose();
    birthDay.dispose();
    guardianName.dispose();
    enteredYear.dispose();
    homeAddress.dispose();
    mobileNumber.dispose();
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
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  bool validator() {
    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        nameWithInitials.text.isEmpty ||
        indexNo.text.isEmpty && indexNo.text.length <= 5||
        selectedGrade == null ||
        _dateController.text.isEmpty ||
        guardianName.text.isEmpty ||
        enteredYear.text.isEmpty ||
        homeAddress.text.isEmpty ||
        mobileNumber.text.isEmpty) {
      return true;
    }
    return false;
  }

  void addStudent() {
    var db = FirebaseFirestore.instance;
    if (validator()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("all field should be filled"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    final student = <String, dynamic>{
      "firstName": firstName.text,
      "lastName": lastName.text,
      "nameWithInitials": nameWithInitials.text,
      "indexNo": indexNo.text,
      "shoolGrade": selectedGrade,
      "birthDay": _dateController.text,
      "guardianName": guardianName.text,
      "enteredYear": enteredYear.text,
      "homeAddress": homeAddress.text,
      "mobileNumber": mobileNumber.text,
    };

    db.collection("students").add(student).then((DocumentReference doc) {
      print("Document snapshot added with ID: ${doc.id}");
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Student added successfully"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      firstName.clear();
      lastName.clear();
      nameWithInitials.clear();
      indexNo.clear();
      birthDay.clear();
      guardianName.clear();
      enteredYear.clear();
      homeAddress.clear();
      mobileNumber.clear();
      selectedGrade = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Sign up",
                style: TextStyle(
                    color: Color.fromARGB(255, 20, 7, 66), fontSize: 20)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("Log in",
                style: TextStyle(
                    color: Color.fromARGB(255, 20, 7, 66), fontSize: 20)),
          ),
        ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: InputField(
                        labelText: "First Name", controller: firstName, keyboardType: TextInputType.text)),
                Expanded(
                    child: InputField(
                        labelText: "Last Name", controller: lastName, keyboardType: TextInputType.text)),
              ],
            ),
            InputField(
                labelText: "Name with Initials", controller: nameWithInitials, keyboardType: TextInputType.text),
            InputField(labelText: "Index no:", controller: indexNo, keyboardType: TextInputType.number),
            DropDownInput(
              itemList: AppConstants.grade,
              onChanged: (value) {
                setState(() {
                  selectedGrade = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "fill by the parent or guardian",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DatePickerInput(
                selectedDate: _selectDate, dateController: _dateController),
            InputField(
                labelText: "name of the guardian", controller: guardianName, keyboardType: TextInputType.text),
            InputField(labelText: "Entered Year", controller: enteredYear, keyboardType: TextInputType.number),
            InputField(labelText: "Home Address", controller: homeAddress, keyboardType: TextInputType.text),
            InputField(
                labelText: "mobile or Tel number", controller: mobileNumber, keyboardType: TextInputType.phone),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 8, 94, 12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: addStudent,
                      child: const Text(
                        "submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 94, 25, 8),
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
