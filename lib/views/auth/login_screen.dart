import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/utils/button.dart';
import 'package:shoppe/views/admin/admin_home_view.dart';
import 'package:shoppe/views/user/user_home_view.dart';

import '../../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isloading = false;
  bool _googleLoading = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/auth/Bubbles1.png'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 250.h),
                    Text('Login',
                        style: TextStyle(
                            fontFamily: 'TitleBold', fontSize: 52.sp)),
                    SizedBox(height: 16.h),
                    Text('Good to see you back',
                        style: TextStyle(
                            fontFamily: 'TextLight', fontSize: 19.sp)),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      isPassword: true,
                      hintText: 'Password',
                      controller: passwordController,
                    ),
                    SizedBox(height: 32.h),
                    _isloading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFF007AFF)))
                        : CustomButton('Login', () {
                            _loginWithEmailPassword(
                              emailController.text.toString(),
                              passwordController.text.toString(),
                            );
                          }),
                    SizedBox(height: 18.h),
                    _buildDividerText('OR'),
                    SizedBox(height: 18.h),
                    _googleLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFF007AFF)))
                        : Center(child: _signInWithGoogleWidget()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInWithGoogleWidget() {
    return InkWell(
      onTap: () {
        _googleSignIn();
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          width: 108.w,
          height: 53.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFD8DADC)),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Image.asset('assets/auth/google.png')),
    );
  }

  Widget _buildDividerText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: Colors.grey, indent: 10.w)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child:
              Text(text, style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
        ),
        Expanded(child: Divider(color: Colors.grey, endIndent: 20.w)),
      ],
    );
  }

  void _loginWithEmailPassword(String email, password) async {
    setState(() {
      _isloading = true;
    });
    try {
      String? user = await FirebaseService().signIn(email, password);
      setState(() {
        _isloading = false;
      });

      //Navigate Based on role
      if (user == "Admin") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AdminHomeView(),
            ));
      } else if (user == "User") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => UserHomeView(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed')),
        );
      }
    } catch (e) {
      print('Error in Sign in: $e');
    }
  }

  void _googleSignIn() async {
    setState(() {
      _googleLoading = true;
    });
    User? user = await FirebaseService().signInWithGoogle();
    setState(() {
      _googleLoading = false;
    });
    if (user != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserHomeView(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign-In Failed')),
      );
    }
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xffD2D2D2)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Color(0xFF007AFF), width: 1.5.w),
        ),
        suffixIcon: isPassword
            ? Icon(Icons.visibility_off, color: Colors.black54, size: 20.sp)
            : null,
      ),
    );
  }
}
