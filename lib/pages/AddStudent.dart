import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/dataRepo/AppConstants.dart';
import 'package:competition_app/components/inputs/DatePickerInput.dart';
import 'package:competition_app/model/AddStudentModel.dart';
import 'package:competition_app/services/Validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../components/inputs/DropDownInput.dart';
import '../components/inputs/Inputs.dart';
import '../dataRepo/StyleConstants.dart';

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

  UploadTask? uploadTask;

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

    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  void addStudent() async {
    final Addstudentmodel studentValidator = Addstudentmodel(
      firstName: firstName.text,
      lastName: lastName.text,
      nameWithInitials: nameWithInitials.text,
      indexNo: indexNo.text,
      shoolGrade: selectedGrade ?? "",
      birthDay: _dateController.text,
      guardianName: guardianName.text,
      enteredYear: enteredYear.text,
      homeAddress: homeAddress.text,
      mobileNumber: mobileNumber.text,
    );

    final allset = Validator.StudentValidator(studentValidator);
    if (allset != true) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(allset),
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

    uploadFile();
  }

  PlatformFile? pickFile;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      pickFile = result.files.first;
    });
  }

  Future<void> uploadFile() async {
    var db = FirebaseFirestore.instance;

    if (pickFile == null) return;

    final path = 'files/${pickFile!.name}';
    final file = File(pickFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask?.whenComplete(() {});

    final urlDownload = await snapshot?.ref.getDownloadURL();

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
      "photoUrl": urlDownload,
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
      setState(() {
        selectedGrade = null;
      });
    });
    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.green,
                  ),
                  Center(
                    child: Text(
                      '${(progress * 100).toStringAsFixed(2)} %',
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Text(
                "Application Form",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 154, 192),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: InputField(
                          labelText: "First Name",
                          controller: firstName,
                          keyboardType: TextInputType.text)),
                  Expanded(
                      child: InputField(
                          labelText: "Last Name",
                          controller: lastName,
                          keyboardType: TextInputType.text)),
                ],
              ),
              InputField(
                  labelText: "Name with Initials",
                  controller: nameWithInitials,
                  keyboardType: TextInputType.text),
              InputField(
                  labelText: "Index no:",
                  controller: indexNo,
                  keyboardType: TextInputType.number),
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
                "Fill by the parent or guardian",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 154, 192),
                ),
              ),
              const SizedBox(height: 10),
              DatePickerInput(
                  selectedDate: _selectDate, dateController: _dateController),
              InputField(
                  labelText: "Name of the guardian",
                  controller: guardianName,
                  keyboardType: TextInputType.text),
              InputField(
                  labelText: "Entered Year",
                  controller: enteredYear,
                  keyboardType: TextInputType.number),
              InputField(
                  labelText: "Home Address",
                  controller: homeAddress,
                  keyboardType: TextInputType.text),
              InputField(
                  labelText: "Mobile or Tel number",
                  controller: mobileNumber,
                  keyboardType: TextInputType.phone),

              //to display the selected image
              Column(children: [
                if (pickFile != null)
                  Container(
                    color: Colors.blue,
                    child: Image.file(
                      File(pickFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
              ]),

              //add photo button
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, top: 10),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 99, 99, 99),
                        width: 2,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.photo,
                          color: Color.fromARGB(255, 155, 136, 136)),
                      TextButton(
                          onPressed: selectFile,
                          child: const Text(
                            "choose a photo",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 8, 94, 12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: addStudent,
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150,
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
              buildProgress(),
            ],
          ),
        ),
      ),
    );
  }
}
