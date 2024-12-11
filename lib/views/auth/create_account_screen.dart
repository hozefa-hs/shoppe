import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/services/firebase_services.dart';
import 'package:shoppe/utils/button.dart';
import 'package:shoppe/views/auth/login_screen.dart';
import 'package:shoppe/views/auth/splash_screen.dart';
import 'package:shoppe/views/user/user_home_view.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  String selectedRole = "User";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.asset('assets/auth/Bubbles.png'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35.h),
                    Text(
                      "Create\nAccount",
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontFamily: 'TitleBold',
                      ),
                    ),
                    SizedBox(height: 40.h),
                    _buildImagePick(),
                    SizedBox(height: 40.h),
                    CustomTextField(
                      hintText: "Name",
                      controller: namecontroller,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: "Email",
                      controller: emailcontroller,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      hintText: "Password",
                      isPassword: true,
                      controller: passwordcontroller,
                    ),
                    SizedBox(height: 16.h),
                    _buildDropDownMenu(),
                    SizedBox(height: 70.h),
                    _isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Color(0xFF007AFF),
                          ))
                        : CustomButton('Create Account', () {
                            _createUserWithEmailPassword(
                              name: namecontroller.text,
                              email: emailcontroller.text,
                              password: passwordcontroller.text,
                              role: selectedRole,
                            );
                          }),
                    SizedBox(height: 16.h),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: 'TextLight',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropDownMenu() {
    return DropdownButtonFormField(
        value: selectedRole,
        decoration: InputDecoration(
          labelText: 'Role',
          border: OutlineInputBorder(),
        ),
        items: ["Admin", "User"].map((role) {
          return DropdownMenuItem(
            child: Text(role),
            value: role,
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedRole = newValue!;
          });
        });
  }

  void _createUserWithEmailPassword(
      {required String name, email, password, role}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = await FirebaseService()
          .signUp(name: name, email: email, password: password, role: role);
      setState(() {
        _isLoading = false;
      });
      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign up Failed')),
        );
      }
    } catch (e) {
      print('Error in Sign up: $e');
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

Widget _buildImagePick() {
  return GestureDetector(
    onTap: () {
      // Add image picker functionality here
    },
    child: Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Color(0xFF007AFF), width: 3.w)),
      child: CircleAvatar(
        radius: 50.r,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.camera_alt,
          size: 35.sp,
          color: const Color(0xFF007AFF),
        ),
      ),
    ),
  );
}
