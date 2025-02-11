import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/views/user/product_detail_screen.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/product_model.dart';

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
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(
                child: FadeTransition(
                  opacity: AlwaysStoppedAnimation(0.5),
                ),
              );
            }

            final products = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
                          stock: product.stock,
                          id: product.id,
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
