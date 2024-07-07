import 'package:competition_app/pages/viewStudentsDetails/ViewData.dart';
import 'package:competition_app/pages/auth/SignUp.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cubit/recentgradings_cubit.dart';
import '../components/common/HedingAnimation.dart';
import '../components/common/HomeCard.dart';
import '../Constants/StyleConstants.dart';
import 'addstudents/AddStudent.dart';
import 'competition/MakeCompetitons.dart';
import 'grading/NewGrading.dart';
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
      BlocProvider.of<RecentgradingsCubit>(context).loadData(context);
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

  void _signOut() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are You sure to sign out?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _auth.logOut();
                    setState(() {
                      _isLoggedIn = false;
                    });
                    
                  },
                  child: const Text("Yes"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.menu,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        if (_isLoggedIn)
                          TextButton(
                            onPressed: _signOut,
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const HeadingAnimation(
                      heading: "Welcome to your Sport Manager"),
                  const Image(
                    image: AssetImage('assets/images/homepageImage.png'),
                    height: 350,
                    width: 350,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HomeCard(
                        buttonText: "Add new Student",
                        color: const Color.fromARGB(255, 33, 0, 65),
                        onPressed: () => _checkUserAuthenticationAndNavigate(
                            const AddStudent()),
                        description: "Add a new student to the database",
                      ),
                      HomeCard(
                        buttonText: "View Students",
                        color: const Color.fromARGB(255, 33, 0, 65),
                        onPressed: () => _checkUserAuthenticationAndNavigate(
                            Viewdata()), // Replace with the actual target page for viewing students
                        description: "View all students in the database",
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
                        color: const Color.fromARGB(255, 33, 0, 65),
                        onPressed: () => _checkUserAuthenticationAndNavigate(
                            NewGrading()), // Replace with the actual target page for grading
                        description:
                            "Create a new grading and add new students to it",
                      ),
                      HomeCard(
                        buttonText: "New Competition",
                        color: const Color.fromARGB(255, 0, 0, 0),
                        onPressed: () => _checkUserAuthenticationAndNavigate(
                            const MakeCompetition()), // Replace with the actual target page for competition
                        description:
                            "Create a new competition, drawings and lot more",
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
    );
  }
}
