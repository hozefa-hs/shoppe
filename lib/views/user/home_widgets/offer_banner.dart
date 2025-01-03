import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferBanner extends StatelessWidget {

  final String image, text;
  final double height;

  const OfferBanner({super.key, required this.image, required this.text, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImage(imageUrl: image, fit: BoxFit.fitHeight,),
          Container(
            height: height.h,
            width: double.infinity,
            color: Colors.black45,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'TitleBold'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}