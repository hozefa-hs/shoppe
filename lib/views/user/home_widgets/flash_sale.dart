import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';
import '../product_detail_screen.dart';

class FlashSale extends StatefulWidget {
  const FlashSale({super.key});

  @override
  State<FlashSale> createState() => _FlashSaleState();
}

class _FlashSaleState extends State<FlashSale> {
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

            final reversedProducts = products.reversed.toList();

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: reversedProducts.length,
              itemBuilder: (context, index) {
                final product = reversedProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          productImage: product.imageUrl,
                          companyName: product.company,
                          productName: product.name,
                          description: product.description,
                          price: product.price,
                        ),
                      ),
                    );
                  },
                  child: Container(
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
                                image: CachedNetworkImageProvider(
                                    product.imageUrl),
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
