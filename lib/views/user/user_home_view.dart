import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/utils/constants.dart';
import 'package:shoppe/controllers/category_controller.dart';

import '../../models/category_model.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BannerCarousel(),
          SizedBox(height: 20.h),
          _buildTitleText('Categories'),
          SizedBox(height: 10.h),
          CategoryButton(),
          SizedBox(height: 20.h),
          _buildTitleText('Popular products'),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildTitleText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'TitleBold'),
      ),
    );
  }
}

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
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
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

class CategoryButton extends StatefulWidget {
  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  final CategoryController _categoryController = CategoryController();

  int selectedIndex = 0; // To track the selected chip

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: StreamBuilder<List<CategoryModel>>(
          stream: _categoryController.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
            return Center(child: Text('Error fetching categories'));
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            final categories = snapshot.data!;
            return Container(
              height: 40.h,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final bool isSelected = selectedIndex == index;
                  return Container(
                    margin: EdgeInsets.only(right: 6.w),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(
                        category.name,
                        style: TextStyle(
                            fontFamily: 'TextRegular',
                            color:
                                isSelected ? Colors.white : Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      selected: isSelected,
                      selectedColor: primaryColor,
                      backgroundColor: Colors.white,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}