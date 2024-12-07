import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up a user with email and password
  Future<User?> signUp(
      {required String name,
      required String email,
      required String password,
      required String role}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //Additionally save credentials to firestore database
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        "name": name.trim(),
        "email": email.trim(),
        "role": role,
      });

      return userCredential.user;
    } catch (e) {
      print("Sign Up Error: $e");
      return null;
    }
  }

  // Sign in user with email and password
  Future<String?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //Fetch user's role from firestore to determine access
      DocumentSnapshot userDoc = await _firestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
      return userDoc['role'];
    } catch (e) {
      print("Sign In Error: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Google Sign in
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; //User cancelled sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }
}
