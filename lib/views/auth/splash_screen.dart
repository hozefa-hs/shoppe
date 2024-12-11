import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/views/auth/create_account_screen.dart';
import 'package:shoppe/views/auth/login_screen.dart';
import 'package:shoppe/views/auth/shared_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      navigateUser();
    });
  }

  Future<void> navigateUser() async {
    // Call checkUser to determine the next screen
    Widget nextScreen = await checkUser();

    // Navigate to the determined screen
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _splashImage(),
          SizedBox(height: 20.h),
          Text(
            'Shoppe',
            style: TextStyle(fontSize: 52.sp, fontFamily: 'TitleBold'),
          ),
          SizedBox(height: 20.h),
          Text(
            "Beautiful eCommerce UI Kit\n for your online store",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 19.sp, fontFamily: 'TextLight'),
          ),
          SizedBox(height: 120.h),
          _button(() {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const CreateAccountScreen()),
            );
          }),
          SizedBox(height: 20.h),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I already have an account  ",
                  style: TextStyle(fontSize: 15.sp, fontFamily: 'TextLight'),
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xff004CFF),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _splashImage() {
    return Center(
      child: Container(
        height: 134.h,
        width: 134.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2.r,
              blurRadius: 15.r,
            ),
          ],
        ),
        child: Image.asset('assets/auth/splash.png'),
      ),
    );
  }

  Widget _button(VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 335.w,
        height: 61.h,
        decoration: BoxDecoration(
          color: const Color(0xff004CFF),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            "Let's get started",
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontFamily: 'TextLight',
            ),
          ),
        ),
      ),
    );
  }
}
