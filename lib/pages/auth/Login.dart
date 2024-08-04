import 'package:competition_app/pages/auth/SignUp.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/GoogleAuth.dart';
import '../../Constants/StyleConstants.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/inputs/Inputs.dart';
import '../../services/AuthService.dart';
import '../HomePage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Authservice _auth = Authservice();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StyleConstants.upperBackgroundContainer,
          StyleConstants.lowerBackgroundContainer,
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          icon: const Icon(
                            Icons.app_registration_rounded,
                            color: Colors.white,
                            size: 25,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const HeadingAnimation(heading: "LOG IN"),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/login.png",
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 30),
                InputField(
                  labelText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                InputField(
                  labelText: "Password",
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(
                          "forget password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 231, 255),
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 28),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      color: const Color.fromARGB(82, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final user = await _auth.logInUserWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "log in",
                        style: TextStyle(
                          color: Color.fromARGB(255, 20, 0, 65),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GoogleAuth(auth: _auth, context: context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
