import 'package:flutter/material.dart';

import '../components/common/HomeCard.dart';
import 'AddStudent.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text("Sign up",
                  style: TextStyle(
                      color: Color.fromARGB(255, 20, 7, 66), fontSize: 20))),
          TextButton(
              onPressed: () {},
              child: const Text("Log in",
                  style: TextStyle(
                      color: Color.fromARGB(255, 20, 7, 66), fontSize: 20)))
        ],
      ),
      body: const Stack(children: [
        Center(
      
            child: Icon(Icons.sports_mma_rounded,
                size: 400, color: Color.fromARGB(220, 235, 185, 151)),
          ),
        
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeCard(
                        buttonText: "Add new Student",
                        targetPage: AddStudent()), //add student card
                    HomeCard(
                        buttonText: "View Students",
                        targetPage: AddStudent()), //view student card
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HomeCard(
                        buttonText: "new Grading",
                        targetPage: AddStudent()), //grading card
                    HomeCard(
                        buttonText: "new Competition",
                        targetPage: AddStudent()), //competition card
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
