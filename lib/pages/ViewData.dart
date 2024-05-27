import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../dataRepo/StyleConstants.dart';

class Viewdata extends StatefulWidget {
  @override
  _ViewdataState createState() => _ViewdataState();
}

class _ViewdataState extends State<Viewdata> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> _getCollection() async {
    QuerySnapshot querySnapshot = await _firestore.collection('students').get();
    List<Map<String, dynamic>> students = [];
    for (var doc in querySnapshot.docs) {
      students.add(doc.data() as Map<String, dynamic>);
    }
    return students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getCollection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found'));
            } else {
              List<Map<String, dynamic>> students = snapshot.data!;
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  var student = students[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Name: ${student['firstName']} ${student['lastName']}"),
                              const SizedBox(
                                width: 20,
                              ),
                              Text('indexNo: ${student['indexNo']}')
                            ],
                          ),
                          subtitle: Image.network(student['photoUrl'] ?? ''),
                        ),
                      ));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
