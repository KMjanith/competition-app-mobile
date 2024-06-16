import 'package:competition_app/pages/HomePage.dart';
import 'package:competition_app/pages/auth/Login.dart';
import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/GoogleAuth.dart';
import '../../components/common/HedingAnimation.dart';
import '../../Constants/StyleConstants.dart';
import '../../components/inputs/Inputs.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = Authservice();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: SingleChildScrollView(
          child: Container(
            // This container ensures the background gradient covers the entire screen
            height: MediaQuery.of(context).size.height,
            decoration: StyleConstants.pageBackground,
            child: Column(
              children: [
                const SizedBox(height: 100),
                const HeadingAnimation(heading: "SIGN UP"),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/add-friend.png",
                  height: 200,
                  width: 200,
                ),

                //email

                InputField(
                  labelText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                //password
                InputField(
                  labelText: "Password",
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                ),

                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text(
                          "already have an account?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 201, 231, 255),
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
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
                      color: const Color.fromARGB(255, 0, 154, 192),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        final man = await _auth.createUserWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                        print(man);
                        if (man != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color.fromARGB(255, 20, 0, 65),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //google sign up
                GoogleAuth(auth: _auth,context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
