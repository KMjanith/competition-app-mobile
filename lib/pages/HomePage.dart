import 'package:competition_app/pages/ViewData.dart';
import 'package:competition_app/pages/auth/SignUp.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import '../components/common/HedingAnimation.dart';
import '../components/common/HomeCard.dart';
import '../Constants/StyleConstants.dart';
import 'AddStudent.dart';
import 'MakeCompetitons.dart';
import 'NewGrading.dart';
import 'auth/Login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = Authservice();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserLoggedInStatus();
  }

  void _checkUserLoggedInStatus() {
    setState(() {
      _isLoggedIn = _auth.isUserLoggedIn();
    });
  }

  void _checkUserAuthenticationAndNavigate(Widget targetPage) {
    if (!_auth.isUserLoggedIn()) {
      _showAuthDialog();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
    }
  }

  void _showAuthDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AlertDialog(
            title: const Text('Authentication Required'),
            content:
                const Text('You need to sign up or log in to use this app.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Sign Up'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUp()),
                  );
                },
              ),
              TextButton(
                child: const Text('Log In'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _signOut() async {
    await _auth.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.menu,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          if (_isLoggedIn)
                            TextButton(
                              onPressed: _signOut,
                              child: const Text(
                                'Sign Out',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                    ),
                    const HeadingAnimation(
                        heading: "Welcome to the Competition App"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HomeCard(
                          buttonText: "Add new Student",
                          color: Color.fromARGB(255, 33, 0, 65),
                          onPressed: () => _checkUserAuthenticationAndNavigate(
                              const AddStudent()),
                        ),
                        HomeCard(
                          buttonText: "View Students",
                          color: Color.fromARGB(255, 33, 0, 65),
                          onPressed: () => _checkUserAuthenticationAndNavigate(
                              Viewdata()), // Replace with the actual target page for viewing students
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HomeCard(
                          buttonText: "New Grading",
                          color: Color.fromARGB(255, 33, 0, 65),
                          onPressed: () => _checkUserAuthenticationAndNavigate(
                              NewGrading()), // Replace with the actual target page for grading
                        ),
                        HomeCard(
                          buttonText: "New Competition",
                          color: Color.fromARGB(255, 0, 0, 0),
                          onPressed: () => _checkUserAuthenticationAndNavigate(
                              const MakeCompetition()), // Replace with the actual target page for competition
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                   
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
