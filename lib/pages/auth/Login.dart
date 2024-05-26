import 'package:flutter/material.dart';
import '../../components/common/HedingAnimation.dart';
import '../../components/dataRepo/StyleConstants.dart';
import '../../components/inputs/Inputs.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
                const HeadingAnimation(heading: "LOG IN"),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/account.png",
                  height: 200,
                  width: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InputField(
                    labelText: "Email",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: InputField(
                    labelText: "Password",
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("forget password?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 201, 231, 255),
                                fontSize: 18)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 154, 192),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "log in",
                        style: TextStyle(
                            color: Color.fromARGB(255, 20, 0, 65), fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
