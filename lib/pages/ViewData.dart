import 'package:competition_app/services/ViewStudent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/common/HedingAnimation.dart';
import '../dataRepo/StyleConstants.dart';

class Viewdata extends StatefulWidget {
  @override
  _ViewdataState createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  
  final _viewStudent = Viewstudent();

  void _onMenuPressed() {
    // Add your menu pressed logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _onMenuPressed,
                  icon: const Icon(Icons.menu,
                      color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
            const HeadingAnimation(heading: "Students data"),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _viewStudent.getCollection(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data found'));
                  } else {
                    List<Map<String, dynamic>> students = snapshot.data!;
                    return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        var student = students[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => _viewStudent.showStudentDialog(student, context),
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
