import 'package:competition_app/dataRepo/StyleConstants.dart';
import 'package:flutter/material.dart';
import '../components/common/HedingAnimation.dart';

class NewGrading extends StatelessWidget {
  const NewGrading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: StyleConstants.cardBackGround,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Add Student'),
              onTap: () {
                Navigator.pushNamed(context, '/addStudent');
              },
            ),
            ListTile(
              title: const Text('View Students'),
              onTap: () {
                Navigator.pushNamed(context, '/viewData');
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: StyleConstants.pageBackground,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: const Icon(Icons.menu, color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ],
              ),
              const HeadingAnimation(heading: "New Grading"),
            ],
          ),
        ),
      ),
    );
  }
}
