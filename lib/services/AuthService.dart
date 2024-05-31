import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/HomePage.dart';

class Authservice {
  final userInstance = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final createdUser = await userInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      return createdUser.user;
    } catch (e) {
      print("Error in creating user: $e");
    }
    return null;
  }

  Future<User?> logInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final loggedInUser = await userInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return loggedInUser.user;
    } catch (e) {
      print("Error in logging in user: $e");
    }
    return null;
  }

  Future<void> logOut() async {
    try {
      await userInstance.signOut();
    } catch (e) {
      print("Error in logging out: $e");
    }
  }

  //to check if user is logged in
  bool isUserLoggedIn() {
    final User? currentUser = userInstance.currentUser;
    return currentUser != null;
  }

  //get the current user id
  String? getCurrentUserId() {
    final User? currentUser = userInstance.currentUser;
    return currentUser?.uid;
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googlrUser = await GoogleSignIn().signIn(); //getting google user
      final googleAuth = await googlrUser?.authentication; //getting google auth
      final credentials = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      return await userInstance.signInWithCredential(credentials);
    } catch (e) {
      print("Error in signing in with Google: $e");
    }
    return null;
  }

  void sigUpWithGoogle(BuildContext context) async {
    final userCred = await signInWithGoogle();
    if (userCred != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }
}
