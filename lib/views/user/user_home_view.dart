import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppe/views/user/home_widgets/best_seller.dart';
import '../../services/firebase_services.dart';
import '../auth/login_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: Text(
          'Shoppe',
          style: TextStyle(fontFamily: 'TitleBold'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: FaIcon(FontAwesomeIcons.arrowRightFromBracket),
            color: Colors.black,
          ),
        ],
      ),
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
            const ProductTile(),
            SizedBox(height: 20.h),
            OfferBanner(
              image: 'https://i.imgur.com/pRgcbpS.png',
              text: 'Super Flash Sale \n         50% off',
              height: 198.h,
            ),
            SizedBox(height: 20.h),
            _buildTitleText('Flash Sale'),
            SizedBox(height: 10.h),
            FlashSale(),
            SizedBox(height: 20.h),
            OfferBanner(
              image: 'https://i.imgur.com/K41Mj7C.png',
              text: 'New Arrival\nSpecial Offer',
              height: 145.h,
            ),
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

  _logout(BuildContext context) async {
    await FirebaseService().signOut().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    });
    const snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Logout',
        message: 'Successfully logout',
        contentType: ContentType.success,
        color: Colors.red,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
