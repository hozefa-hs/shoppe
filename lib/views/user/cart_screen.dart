import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/models/cart_model.dart';
import 'package:shoppe/utils/button.dart';
import 'package:shoppe/controllers/cart_controller.dart';
import 'package:shoppe/views/user/bottom_navbar.dart';


class CartScreen extends StatelessWidget {
  final CartController cartController = CartController();

  CartScreen({Key? key}) : super(key: key);

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
              // List of products
              StreamBuilder<List<CartModel>>(
                stream: cartController.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final products = snapshot.data!;

                  if (products.isEmpty) {
                    return const EmptyCartScreen();
                  }

                  return Column(
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return OrderItemCard(
                            imageUrl: product.imageUrl,
                            title: product.name,
                            price: product.price.toDouble(),
                            quantity: product.quantity,
                            originalPrice: null,
                          );
                        },
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

                      OrderSummaryCard(products: products),

                      SizedBox(height: 15.h),

                      CustomButton('Continue', () {}),
                    ],
                  );
                },
              ),
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
  final double price;
  final String? originalPrice;
  final int quantity;

  const OrderItemCard({
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    super.key,
    required this.quantity,
  });

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹${price.toString()}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'TextRegular',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Qty: $quantity',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                        fontFamily: 'TextRegular',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Product amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${price * quantity}",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'TextRegular',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  final List<CartModel> products;

  OrderSummaryCard({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double subtotal = products.fold(
        0, (sum, product) => sum + product.price * product.quantity);
    double GST = subtotal * 12 / 100;
    double discount = 10;
    double total = subtotal + GST - discount;
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
          SummaryRow(
            label: 'Subtotal',
            value: '₹${subtotal.toStringAsFixed(2)}',
          ),
          SizedBox(height: 8.h),
          const SummaryRow(
              label: 'Shipping Fee', value: 'Free', valueColor: Colors.green),
          SizedBox(height: 8.h),
          SummaryRow(label: 'Discount', value: '- ₹$discount'),
          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 16.h),
          SummaryRow(label: 'Estimated GST', value: '₹$GST'),
          SizedBox(height: 8.h),
          SummaryRow(
            label: 'Total (Include GST)',
            value: '₹$total',
            isBold: true,
          ),
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

/*-------------------Empty Cart Screen-------------------------------------------------*/

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 300.h,
          child: Column(
            children: [
              const Spacer(flex: 2),
              ErrorInfo(
                title: "Empty Cart!",
                description:
                    "It seems like you haven't added anything to your cart yet. Let's find some great items to fill it up!",
                // button: you can pass your custom button,
                btnText: "Discover Products",
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserBottomNavBar(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold, fontFamily: 'TitleBold'),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'TitleMedium'),
            ),
            SizedBox(height: 10.h),
            button ?? CustomButton(btnText ?? "Retry".toUpperCase(), press),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
