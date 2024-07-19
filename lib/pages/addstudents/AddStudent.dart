import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:competition_app/components/buttons/CancelButton.dart';
import 'package:competition_app/components/buttons/SubmitButton.dart';
import 'package:competition_app/Constants/AppConstants.dart';
import 'package:competition_app/components/common/HedingAnimation.dart';
import 'package:competition_app/components/inputs/DatePickerInput.dart';
import 'package:competition_app/model/AddStudentModel.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:competition_app/services/Validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';
import '../../cubit/db_cubit.dart';
import '../../components/buttons/AddPhotoButton.dart';
import '../../components/inputs/DropDownInput.dart';
import '../../components/inputs/Inputs.dart';
import '../../Constants/StyleConstants.dart';

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
    print("in the add student method");
    log("scoolGrad: $selectedGrade");
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

    //form validator
    final allset = Validator.StudentValidator(studentValidator);

    if (allset != true) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: allset,
        onCancelBtnTap: () {
          Navigator.of(context).pop();
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

  //function to upload the file to the firebase storage
  Future<void> uploadFile() async {
    var db = BlocProvider.of<DbCubit>(context).firestore;

    if (pickFile == null) return;

    final path = 'files/${pickFile!.name}';
    final file = File(pickFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask?.whenComplete(() {});

    final urlDownload = await snapshot?.ref
        .getDownloadURL(); //taking the download url to store in the firestore

    // Get the current user's UID
    final auth = Authservice();
    final uid = auth.getCurrentUserId();

    //this map will store in the firestore document
    final student = <String, dynamic>{
      "user": uid,
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

    log("scoolGrad: $selectedGrade");

    db.collection("students").add(student).then((DocumentReference doc) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: "Student added successfully",
        onConfirmBtnTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: const Icon(Icons.menu,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
                const HeadingAnimation(heading: "Add New Student"),
                const Text(
                  "Application Form",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 187, 227, 236),
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
                  title: "Grade",
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
                    color: Color.fromARGB(255, 3, 54, 68),
                  ),
                ),

                const SizedBox(height: 10),
                DatePickerInput(
                  selectedDate: _selectDate,
                  dateController: _dateController,
                  lableName: "Date OF Birth",
                ),
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
                AddPhotoButton(selectFile: selectFile),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //submit button
                    SubmitButton(
                      addStudent: addStudent,
                      title: "Add Student",
                    ),
                    //Cancel Button
                    const CancelButton()
                  ],
                ),
                buildProgress(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
