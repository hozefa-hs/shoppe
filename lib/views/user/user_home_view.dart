import 'package:flutter/material.dart';
import 'package:shoppe/services/firebase_services.dart';
import 'package:shoppe/views/auth/login_screen.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Home Screen',
              style: TextStyle(fontFamily: 'TitleBold'),
            ),
            ElevatedButton(
              onPressed: () {
                _logout(context);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout successfully')));
              },
              child: Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }

  _logout(BuildContext context) async {
    await FirebaseService().signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
  }
}
