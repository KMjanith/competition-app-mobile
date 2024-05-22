import 'package:competition_app/components/common/HomeCard.dart';
import 'package:flutter/material.dart';
import 'pages/addStudent/AddStudent.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Student Management System"),
      ),
      body: const Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeCard(buttonText:"Add new Student", targetPage: AddStudent()),   //add student card
                HomeCard(buttonText:"View Students", targetPage: AddStudent()),     //view student card
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HomeCard(buttonText:"new Grading", targetPage: AddStudent()),    //grading card
                HomeCard(buttonText:"new Competition", targetPage: AddStudent()),   //competition card
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
