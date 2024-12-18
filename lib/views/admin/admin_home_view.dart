import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/views/admin/manage_categories_view.dart';
import 'package:shoppe/views/admin/manage_products_view.dart';

import '../../services/firebase_services.dart';
import '../auth/login_screen.dart';

class AdminHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                children: [
                  _buildDashboardCard(
                    context,
                    title: "Manage Categories",
                    icon: Icons.category,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageCategoryView(),
                          ));
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: "Manage Products",
                    icon: Icons.shopping_cart,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ManageProductsView(),
                          ));
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: "View Orders",
                    icon: Icons.list_alt,
                    onTap: () {
                      // Navigate to view orders screen
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: "User Management",
                    icon: Icons.person,
                    onTap: () {
                      // Navigate to user management screen
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: "Settings",
                    icon: Icons.settings,
                    onTap: () {
                      // Navigate to settings screen
                    },
                  ),
                  _buildDashboardCard(
                    context,
                    title: "Log out",
                    icon: Icons.logout,
                    onTap: () {
                      _logout(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        "Admin Dashboard",
        style: TextStyle(fontFamily: "TitleBold"),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildDashboardCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Color(0xFF007AFF),
              ),
              SizedBox(height: 10.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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
