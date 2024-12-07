import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppe/views/auth/splash_screen.dart';

import '../admin/admin_home_view.dart';
import '../user/user_home_view.dart';
import 'login_screen.dart';

Future<Widget> checkUser() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Fetch the user's role from Firestore
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userDoc.exists) {
      final String role = userDoc['role'];

      if (role == 'Admin') {
        return AdminHomeView();
      } else if (role == 'User') {
        return UserHomeView();
      }
    }

    // If the role is not defined, navigate to an error screen or logout
    return Container(); // Optionally, replace this with your own error handling.
  } else {
    // User is not logged in
    return SplashScreen();
  }
}
