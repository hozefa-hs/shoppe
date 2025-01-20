import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerCarousel extends StatelessWidget {
  final List<String> bannerImages = [
    'https://i.imgur.com/pRgcbpS.png',
    'https://i.imgur.com/UP7xhPG.png',
    'https://i.imgur.com/J1Qjut7.png',
    'https://i.imgur.com/8REExBV.png',
    'https://i.imgur.com/R4iKkDD.png'
  ];

  final List<String> bannerText = [
    'New items with\nFree shipping',
    'Black\nFriday\nCollection',
    'Grab\nYours Now',
    'Summer Sale\nUpto 80% off',
    'Summer Sale\nUpto 80% off',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 180.h,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              enlargeCenterPage: true,
            ),
            items: bannerImages.asMap().entries.map((entry) {
              int index = entry.key;
              String image = entry.value;
              String text = bannerText[index];

              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => const Center(
                            child: FadeTransition(
                              opacity: AlwaysStoppedAnimation(0.5),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.w),
                          child: Text(
                            text,
                            style: TextStyle(
                                fontFamily: 'TitleBold',
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 28.sp),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
