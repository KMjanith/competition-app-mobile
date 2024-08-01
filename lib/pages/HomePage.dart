import 'package:competition_app/pages/competition/ScoreBoardCreation.dart';
import 'package:competition_app/pages/viewData/ViewData.dart';
import 'package:competition_app/pages/auth/SignUp.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/quickalert.dart';
import '../cubit/news_alerrt_cubit.dart';
import '../cubit/recentgradings_cubit.dart';
import '../components/common/HedingAnimation.dart';
import '../components/homepage/HomeCard.dart';
import '../Constants/StyleConstants.dart';
import '../components/homepage/NewsCard.dart';
import '../services/HomePageServices.dart';
import 'addstudents/AddStudent.dart';
import 'DrawMaker.dart';
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
  final homePageService = HomePageService();

  @override
  void initState() {
    super.initState();
    _checkUserLoggedInStatus();
   // BlocProvider.of<NewsAlertCubit>(context).getNews();
  }

  void _checkUserLoggedInStatus() {
    setState(() {
      _isLoggedIn = _auth.isUserLoggedIn();
    });
  }

  //-------------------------------------------------------------------------------------CHECK USER AUTHENTICATION AND NAVIGATE-------------------------------------------------------
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

  //-------------------------------------------------------------------------------------------------SHOW AUTH DIALOG-------------------------------------------------------
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

  //--------------------------------------------------------------------------------------------SIGN OUT-------------------------------------------------------
  void _signOut() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to logout',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
      onConfirmBtnTap: () async {
        Navigator.pop(context);
        await _auth.logOut();
        setState(() {
          _isLoggedIn = false;
        });
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
    );
  }

  //-------------------------------------------------------------------------------------BUILD CONTEXT-------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          //StyleConstants.lowerBackgroundContainer,

          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child:  Row(
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
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  const HeadingAnimation(
                      heading: "Welcome to your Sport Manager"),
                  const Image(
                    image: AssetImage('assets/images/homepageImage.png'),
                    height: 350,
                    width: 350,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 25, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Latest Sports News",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  //-----------------------------------------------------------------------------------------NEWS ROW-------------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: BlocBuilder<NewsAlertCubit, NewsAlertState>(
                      builder: (context, state) {
                        if (state is NewsAlertLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is NewsAlertLoaded) {
                          return SizedBox(
                            height: 220,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.articles.length,
                              itemBuilder: (context, index) {
                                return NewsCard(
                                  article: state.articles[index],
                                );
                              },
                            ),
                          );
                        } else if (state is NewsAlertError) {
                          return Text(state.message);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),

                  //--------------------------------------------------------------------------------------------FUNCTIONS-------------------------------------------------------
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(62, 255, 255, 255),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(left: 25, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Lets Play",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "KARATE",
                            style: GoogleFonts.roboto(
                                color: const Color.fromARGB(221, 255, 255, 255),
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          //-----------------------------------------------------------------------------FIRST ROW-------------------------------------------------------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HomeCard(
                                buttonText: "Add new Student",
                                color: const Color.fromARGB(255, 33, 0, 65),
                                onPressed: () =>
                                    _checkUserAuthenticationAndNavigate(
                                        const AddStudent()),
                                description:
                                    "Add a new student to the database",
                              ),
                              HomeCard(
                                buttonText: "View Students",
                                color: const Color.fromARGB(255, 33, 0, 65),
                                onPressed: () =>
                                    _checkUserAuthenticationAndNavigate(
                                        Viewdata()), // Replace with the actual target page for viewing students
                                description:
                                    "View all students in the database",
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          //-----------------------------------------------------------------------------SECOND ROW-------------------------------------------------------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HomeCard(
                                buttonText: "New Grading",
                                color: const Color.fromARGB(255, 33, 0, 65),
                                onPressed: () =>
                                    _checkUserAuthenticationAndNavigate(
                                        NewGrading()), // Replace with the actual target page for grading
                                description:
                                    "Create a new grading and add new students to it",
                              ),
                              HomeCard(
                                buttonText: "New Competition",
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: () =>
                                    _checkUserAuthenticationAndNavigate(
                                        const MakeCompetition()), // Replace with the actual target page for competition
                                description:
                                    "Create a new competition, drawings and lot more",
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              HomeCard(
                                buttonText: "Draw Maker",
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: () =>
                                    _checkUserAuthenticationAndNavigate(
                                        const DrawMaker()), // Replace with the actual target page for competition
                                description:
                                    "you can monitor your player path to win, and also you can create a draw for your competition",
                              ),
                              HomeCard(
                                buttonText: "Score Board",
                                color: const Color.fromARGB(255, 0, 0, 0),
                                onPressed: () =>
                                    _checkUserAuthenticationAndNavigate(
                                        const ScoreBoardCreation()), // Replace with the actual target page for competition
                                description:
                                    "kumite score board",
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
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
