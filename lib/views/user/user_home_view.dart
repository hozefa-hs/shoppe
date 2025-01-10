import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/views/user/home_widgets/best_seller.dart';
import 'home_widgets/carousel.dart';
import 'home_widgets/category.dart';
import 'home_widgets/flash_sale.dart';
import 'home_widgets/offer_banner.dart';
import 'home_widgets/popular_products.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 20.h),
            OfferBanner(image: 'https://i.imgur.com/pRgcbpS.png', text: 'Super Flash Sale \n         50% off', height: 198.h,),
            SizedBox(height: 20.h),
            _buildTitleText('Flash Sale'),
            SizedBox(height: 10.h),
            FlashSale(),
            SizedBox(height: 20.h),
            OfferBanner(image: 'https://i.imgur.com/K41Mj7C.png', text: 'New Arrival\nSpecial Offer', height: 145.h,),
            SizedBox(height: 20.h),
            _buildTitleText('Best Seller'),
            SizedBox(height: 10.h),
            BestSeller(),
            SizedBox(height: 20.h),
          ],
        ),
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
