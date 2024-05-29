import 'package:competition_app/services/AuthService.dart';
import 'package:flutter/material.dart';
import '../../components/buttons/GoogleAuth.dart';
import '../../components/common/HedingAnimation.dart';
import '../../dataRepo/StyleConstants.dart';
import '../../components/inputs/Inputs.dart';
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
      body: Container(
        decoration: StyleConstants.pageBackground,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: StyleConstants.pageBackground,
            child: Column(
              children: [
                const SizedBox(height: 100),
                const HeadingAnimation(heading: "LOG IN"),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/account.png",
                  height: 200,
                  width: 200,
                ),
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

                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 40),
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
                      color: const Color.fromARGB(255, 0, 154, 192),
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
                const SizedBox(
                  height: 10,
                ),

                //google log in
                GoogleAuth(auth: _auth, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
