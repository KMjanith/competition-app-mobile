import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Viewstudent with ChangeNotifier {
  Viewstudent() {
    //getCollection();
  }

  void showStudentDialog(Map<String, dynamic> student, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          title: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: const Text(
              "INFORMATION",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          content: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Container(
                    height: 150,
                    width: 150,
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
                const SizedBox(height: 16),
                _buildInfoText(
                    'Name:', '${student['firstName']} ${student['lastName']}'),
                _buildInfoText('Index No:', '${student['indexNo']}'),
                _buildInfoText(
                    'Name With Initials:', '${student['nameWithInitials']}'),
                _buildInfoText('School Grade:', '${student['schoolGrade']}'),
                _buildInfoText('Birth Day:', '${student['birthDay']}'),
                _buildInfoText('Guardian Name:', '${student['guardianName']}'),
                _buildInfoText('Entered Year:', '${student['enteredYear']}'),
                _buildInfoText('Home Address:', '${student['homeAddress']}'),
                _buildInfoText('Mobile Number:', '${student['mobileNumber']}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: GoogleFonts.radioCanada(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: value,
              style: GoogleFonts.radioCanada(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
