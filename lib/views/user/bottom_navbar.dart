import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shoppe/views/user/cart_screen.dart';
import 'package:shoppe/views/user/user_home_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../services/firebase_services.dart';
import '../../utils/constants.dart';
import '../auth/login_screen.dart';

class UserBottomNavBar extends StatefulWidget {
  const UserBottomNavBar({super.key});

  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  int _selectedIndex = 0; //Default index of first screen

  // A placeholder for your screen widgets
  final List<Widget> _widgetOptions = [
    UserHomeView(),
    CartScreen(),
    Text('Settings')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        color: Colors.white,
        child: BottomNavigationBar(
          enableFeedback: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          // selectedLabelStyle: TextStyle(color: primaryColor),
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              activeIcon: FaIcon(FontAwesomeIcons.house),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('2'),
                child: FaIcon(FontAwesomeIcons.cartShopping),
              ),
              activeIcon: FaIcon(FontAwesomeIcons.list),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.gear),
              activeIcon: FaIcon(FontAwesomeIcons.gear),
              label: "Bookmark",
            ),
          ],
        ),
      ),
    );
  }
}
