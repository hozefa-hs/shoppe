import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/controllers/product_controller.dart';
import 'package:shoppe/models/product_model.dart';
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
          const CategoryButton(),
          SizedBox(height: 20.h),
          _buildTitleText('Popular products'),
          SizedBox(height: 10.h),
          ProductTile(),
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

/*-------------Category Button---------------------------------------------*/

class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

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
                            color: isSelected ? Colors.white : Colors.black,
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

/*-------------Products List----------------------------------------------*/

class ProductTile extends StatefulWidget {
  const ProductTile({super.key});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  ProductController _productController = ProductController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Container(
        height: 215.h,
        // color: Colors.greenAccent,
        child: StreamBuilder<List<ProductModel>>(
          stream: _productController.getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            final products = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(right: 8.w),
                  width: 150.w,
                  decoration: BoxDecoration(
                    // color: Colors.grey,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(width: 1, color: Colors.grey.shade500),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 120.h,
                        width: 133.w,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(product.imageUrl),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6.h),
                            Text(
                              product.company,
                              style: TextStyle(
                                  fontSize: 12.sp, fontFamily: 'TextLight'),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'TitleMedium',
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "₹${product.price.round()}",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: 'TextRegular',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
