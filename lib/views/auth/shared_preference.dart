import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shoppe/views/auth/login_screen.dart';
import 'package:shoppe/views/auth/splash_screen.dart';
import 'package:shoppe/views/admin/admin_home_view.dart';
import 'package:shoppe/views/user/user_home_view.dart';

Future<Widget> checkUser() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
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
    } catch (e) {
      debugPrint('Error fetching user role: $e');
      // Handle error if needed
    }
  }

  // If no user is logged in or an error occurs, return the LoginScreen
  return LoginScreen();
}
