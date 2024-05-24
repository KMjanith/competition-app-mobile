import 'package:competition_app/components/common/HomeCard.dart';
import 'package:flutter/material.dart';
import 'pages/addStudent/AddStudent.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
        title: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          TextButton(onPressed: (){}, child: Text("Sign up", style: TextStyle(color: Color.fromARGB(255, 20, 7, 66), fontSize: 20))),
          TextButton(onPressed: (){}, child: Text("Log in", style: TextStyle(color: Color.fromARGB(255, 20, 7, 66), fontSize: 20)))
        ],
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
      ),
    );
  }
}
