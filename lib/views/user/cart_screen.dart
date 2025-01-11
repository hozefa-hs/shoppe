import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/utils/button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                'Review your order',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'TitleBold',
                ),
              ),
              SizedBox(height: 16.h),
          
              // List of products
              ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: const [
                  OrderItemCard(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Ni-Mk_BC1FX6wSH1QXsQKG3HNneBVwZGmg&s',
                    title: 'Mountain Beta Warehouse',
                    price: '\$800',
                  ),
                  OrderItemCard(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Ni-Mk_BC1FX6wSH1QXsQKG3HNneBVwZGmg&s',
                    title: 'FS - Nike Air Max 270 Really React',
                    price: '\$390.36',
                    originalPrice: '\$650.62',
                  ),
                ],
              ),
              SizedBox(height: 16.h),
          
              // Coupon code input
              Text(
                'Your Coupon code',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TitleBold'),
              ),
              SizedBox(height: 8.h),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Type coupon code',
                  prefixIcon: Icon(Icons.discount_outlined, size: 20.w),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
          
              // Order Summary
              const OrderSummaryCard(),
          
              SizedBox(height: 15.h),
          
              CustomButton('Continue', () {})
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Cart',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontFamily: 'TitleBold',
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}

class OrderItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final String? originalPrice;

  const OrderItemCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageUrl,
              height: 80.h,
              width: 80.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'TitleMedium',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TextRegular',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    if (originalPrice != null)
                      Text(
                        originalPrice!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SummaryRow(label: 'Subtotal', value: '\$169'),
          SizedBox(height: 8.h),
          SummaryRow(
              label: 'Shipping Fee', value: 'Free', valueColor: Colors.green),
          SizedBox(height: 8.h),
          SummaryRow(label: 'Discount', value: '-\$10'),
          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 16.h),
          SummaryRow(label: 'Estimated GST', value: '\$5'),
          SizedBox(height: 8.h),
          SummaryRow(
              label: 'Total (Include GST)', value: '\$185', isBold: true),
        ],
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'TitleMedium',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'TextRegular',
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: valueColor ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
