import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/services/firebase_options.dart';
import 'package:shoppe/views/admin/manage_products_view.dart';
import 'package:shoppe/views/auth/shared_preference.dart';
import 'package:shoppe/views/auth/splash_screen.dart';
import 'package:shoppe/views/user/product_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoppe',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: ProductDetailScreen(),
      ),
    );
  }
}
