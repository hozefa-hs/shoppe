import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton(this.text, this.onPressed);

  String text;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 335.w,
        height: 61.h,
        decoration: BoxDecoration(
            color: Color(0xff004CFF),
            borderRadius: BorderRadius.circular(16.r)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22.sp, color: Colors.white, fontFamily: 'TextLight'),
          ),
        ),
      ),
    );
  }
}
