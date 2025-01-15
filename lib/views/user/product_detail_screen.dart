import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/controllers/cart_controller.dart';
import 'package:shoppe/models/cart_model.dart';

class ProductDetailScreen extends StatelessWidget {
  String id, companyName, productName, description, productImage;
  double price;
  int stock;

  ProductDetailScreen(
      {super.key,
      required this.id,
      required this.companyName,
      required this.productName,
      required this.description,
      required this.price,
      required this.productImage,
      required this.stock});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel
              SizedBox(
                height: 300.h,
                child: PageView(
                  children: [
                    ProductImageCard(imageUrl: productImage),
                    const ProductImageCard(
                        imageUrl: 'https://i.imgur.com/pRgcbpS.png'),
                    ProductImageCard(imageUrl: productImage),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              Text(
                companyName,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontFamily: 'TitleMedium'),
              ),
              SizedBox(height: 4.h),
              Text(
                productName,
                style: TextStyle(
                  fontFamily: 'TitleBold',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const Text(
                      'Available in stock',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TitleMedium'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4.w),
                      Text(
                        '4.4',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '(126 Reviews)',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),

              // Product Info Section
              Text(
                'Product info',
                style: TextStyle(
                  fontFamily: 'TitleMedium',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                description,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontFamily: 'TextRegular'),
              ),
              SizedBox(height: 20.h),

              // Product Details, Shipping, Returns
              const Divider(),
              const ProductOption(
                icon: Icons.info_outline,
                title: 'Product Details',
                onTap: null,
              ),
              const Divider(),
              const ProductOption(
                icon: Icons.local_shipping_outlined,
                title: 'Shipping Information',
                onTap: null,
              ),
              const Divider(),
              const ProductOption(
                icon: Icons.assignment_return_outlined,
                title: 'Returns',
                onTap: null,
              ),
              const Divider(),
              _buildReviewsSection(),
              SizedBox(height: 10.h),
              Divider(),
              SizedBox(height: 10.h),
              // "You may also like" Section
              Text(
                'You may also like',
                style: TextStyle(fontSize: 16.sp, fontFamily: 'TitleBold'),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 200.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  separatorBuilder: (_, __) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return const SimilarProductCard();
                  },
                ),
              ),
              SizedBox(height: 20.h),
              // Bottom Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${price.round()}",
                          style: TextStyle(
                            fontFamily: 'TextRegular',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Unit price',
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                              fontFamily: 'TextLight',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showQuantityDialog(
                            context, id, productName, stock, price);
                      },
                      child: Container(
                        width: 180.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Color(0xff004CFF),
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Center(
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.white,
                                fontFamily: 'TextLight'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        '$productName',
        style: TextStyle(color: Colors.black, fontFamily: 'TitleBold'),
      ),
      centerTitle: true,
    );
  }

  Widget _buildRatingBar(String label, double value) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
                fontFamily: 'TextLight',
                fontSize: 14.sp,
                color: Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.w),
          Container(
            width: 150.w,
            height: 6.h,
            child: LinearProgressIndicator(
              value: value,
              borderRadius: BorderRadius.circular(10.r),
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '4.3',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '/5',
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                ),
              ],
            ),
            Text(
              'Based on 128\nReviews',
              style: TextStyle(
                  fontSize: 18.sp, color: Colors.grey, fontFamily: 'TextLight'),
            ),
          ],
        ),
        SizedBox(width: 15.w),
        Column(
          children: [
            _buildRatingBar('5 Star', 0.8),
            _buildRatingBar('4 Star', 0.6),
            _buildRatingBar('3 Star', 0.4),
            _buildRatingBar('2 Star', 0.2),
            _buildRatingBar('1 Star', 0.1),
          ],
        ),
      ],
    );
  }

  Future<void> showQuantityDialog(BuildContext context, String id,
      String productName, int quantity, double price) {
    final quantityNotifier = ValueNotifier<int>(1);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable: quantityNotifier,
              builder: (context, Quantity, child) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: Text('Available Quantity: $quantity'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (Quantity > 1) {
                            quantityNotifier.value = Quantity - 1;
                          }
                        },
                      ),
                      Text('$Quantity', style: TextStyle(fontSize: 24)),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (Quantity < quantity) {
                            quantityNotifier.value = Quantity + 1;
                          }
                        },
                      ),
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff004CFF),
                            fontFamily: 'TextLight'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //add to cart
                        addToCart(id, productName, Quantity, price);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 130.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            color: const Color(0xff004CFF),
                            borderRadius: BorderRadius.circular(16.r)),
                        child: Center(
                          child: Text(
                            'Add to cart',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontFamily: 'TextLight'),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              });
        });
  }

  //add to cart function
  void addToCart(String id, String productName, int quantity, double price) {
    CartModel cartModel = CartModel(
        id: id,
        imageUrl: productImage,
        name: productName,
        price: price,
        quantity: quantity);
    CartController().addProduct(cartModel);

    AwesomeSnackbarContent successSnackBar = const AwesomeSnackbarContent(
      contentType: ContentType.success,
      title: 'Success',
      message: 'Product added to cart',
    );
  }
}

class ProductImageCard extends StatelessWidget {
  final String imageUrl;

  const ProductImageCard({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}

class ProductOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProductOption(
      {required this.icon, required this.title, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'TitleMedium',
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class SimilarProductCard extends StatelessWidget {
  const SimilarProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  'https://i.imgur.com/pRgcbpS.png',
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    '25% off',
                    style: TextStyle(fontSize: 10.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'LIPSY LONDON',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          Text(
            'Sleeveless Tiered Dobby Swing Dr...',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              Text(
                '\$20.99',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '\$24.65',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
