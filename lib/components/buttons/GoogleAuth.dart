import "package:competition_app/services/AuthService.dart";
import "package:flutter/material.dart";

class GoogleAuth extends StatelessWidget {
  final Authservice auth;
  final BuildContext context;
  const GoogleAuth({super.key, required this.auth, required this.context});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28, right: 28),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 251, 255),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          onPressed: () async {
            auth.sigUpWithGoogle(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/search.png",
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 10),
              const Text(
                "Continue with Google",
                style: TextStyle(
                  color: Color.fromARGB(255, 20, 0, 65),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
