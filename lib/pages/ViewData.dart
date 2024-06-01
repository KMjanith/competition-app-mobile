import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/common/CustomDrawer.dart';
import '../components/common/ErrorAlert.dart';
import '../components/common/HedingAnimation.dart';
import '../components/inputs/Inputs.dart';
import '../dataRepo/StyleConstants.dart';
import '../services/ViewStudent.dart';

class Viewdata extends StatefulWidget {
  @override
  _ViewdataState createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Viewstudent>(context, listen: false).getCollection();
    });
  }

  CustomDrawer _returnDrawer(BuildContext context) {
    
    final indexInputController = TextEditingController();
    return CustomDrawer(
      drawerItems: [
        ListTile(
          title: const Text('Index No'),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add index number"),
                  actions: [
                    InputField(
                      controller: indexInputController,
                      keyboardType: TextInputType.number,
                      labelText: "Index No",
                    ),
                    TextButton(
                      onPressed: () {
                        final viewStudent =
                            Provider.of<Viewstudent>(context, listen: false);
                        final indexNo = indexInputController.text;
                        final student = viewStudent.students.firstWhere(
                          (student) => student['indexNo'] == indexNo,
                          orElse: () => Map<String, dynamic>(),
                        );

                        // ignore: unnecessary_null_comparison
                        if (student.isNotEmpty) {
                          viewStudent.showStudentDialog(student, context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const ErrorAlert(
                                  description: "Student not found");
                            },
                          );
                        }
                      },
                      child: const Text("Filter by index"),
                    ),
                  ],
                );
              },
            );
          },
        ),
        ListTile(
          title: const Text('View Students'),
          onTap: () {},
        ),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _returnDrawer(context),
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(Icons.menu,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
            const HeadingAnimation(heading: "Students data"),
            Expanded(
              child: Consumer<Viewstudent>(
                builder: (context, viewStudent, child) {
                  if (viewStudent.students.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<Map<String, dynamic>> students = viewStudent.students;
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        var student = students[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () =>
                                viewStudent.showStudentDialog(student, context),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: StyleConstants.cardBackGround,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 250,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name: ${student['firstName']} ${student['lastName']}",
                                            style: GoogleFonts.radioCanada(
                                                fontSize: 20),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Index No: ${student['indexNo']}',
                                            style: GoogleFonts.radioCanada(
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipOval(
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.black,
                                        child: student['photoUrl'] != null &&
                                                student['photoUrl'].isNotEmpty
                                            ? Image.network(
                                                student['photoUrl'],
                                                fit: BoxFit.cover,
                                              )
                                            : const Icon(Icons.person,
                                                size: 50, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
