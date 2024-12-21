import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/utils/button.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class ManageProductsView extends StatefulWidget {
  @override
  _ManageProductsViewState createState() => _ManageProductsViewState();
}

class _ManageProductsViewState extends State<ManageProductsView> {
  final ProductController _controller = ProductController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  String? _selectedCategory;
  String? _imageUrl;

  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _productForm(),
          ),
          CustomButton('Add Product', () {
            _addProduct();
          }),
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 20),
          Text(
            'Products List',
            style: TextStyle(fontFamily: 'TitleBold', fontSize: 22.sp),
          ),
          Expanded(
            child: StreamBuilder<List<ProductModel>>(
              stream: _controller.getProducts(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error: ${snapshot.error}'));
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final products = snapshot.data!;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Card(
                      color: Colors.white,
                      elevation: 4,
                      child: InkWell(
                        onTap: () => _updateProduct(product),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            width: 50,
                            height: 50,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                _controller.deleteProduct(product.id),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Text(
        "Manage Products",
        style: TextStyle(fontFamily: "TitleBold"),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Future<void> _fetchCategories() async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      setState(() {
        _categories =
            querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching categories: $e')),
      );
    }
  }

  void _addProduct() async {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _companyController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _stockController.text.isNotEmpty &&
        _selectedCategory != null &&
        _imageUrl != null) {
      final product = ProductModel(
        id: DateTime.now().toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        category: _selectedCategory!,
        imageUrl: _imageUrl!,
        company: _companyController.text.trim(),
      );
      await _controller.addProduct(product);
      _clearFields();
    }
  }

  void _updateProduct(ProductModel product) async {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();
    _stockController.text = product.stock.toString();
    _companyController.text = product.company;
    _selectedCategory = product.category;
    _imageUrl = product.imageUrl;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Product'),
        content: _productForm(),
        actions: [
          TextButton(
            onPressed: () {
              _clearFields();
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isNotEmpty &&
                  _companyController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty &&
                  _priceController.text.isNotEmpty &&
                  _stockController.text.isNotEmpty &&
                  _selectedCategory != null &&
                  _imageUrl != null) {
                final updatedProduct = ProductModel(
                  id: product.id,
                  name: _nameController.text.trim(),
                  description: _descriptionController.text.trim(),
                  price: double.parse(_priceController.text),
                  stock: int.parse(_stockController.text),
                  category: _selectedCategory!,
                  imageUrl: _imageUrl!,
                  company: _companyController.text.trim(),
                );
                await _controller.updateProduct(updatedProduct);
                Navigator.pop(context);
                _clearFields();
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _clearFields() {
    _nameController.clear();
    _companyController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _stockController.clear();
    setState(() {
      _selectedCategory = null;
      _imageUrl = null;
    });
  }

  Widget _productForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          hintText: 'Product Name',
          controller: _nameController,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 7.h),
        CustomTextField(
          hintText: 'Company Name',
          controller: _companyController,
          textInputType: TextInputType.text,
        ),
        SizedBox(height: 7.h),
        CustomTextField(
            hintText: 'Description',
            controller: _descriptionController,
            textInputType: TextInputType.text),
        SizedBox(height: 7.h),
        CustomTextField(
            hintText: 'Price',
            controller: _priceController,
            textInputType: TextInputType.number),
        SizedBox(height: 7.h),
        CustomTextField(
            hintText: 'Stock',
            controller: _stockController,
            textInputType: TextInputType.number),
        SizedBox(height: 7.h),
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            hintText: 'Image URL',
            hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xffD2D2D2)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: Color(0xFF007AFF), width: 1.5.w),
            ),
          ),
          onChanged: (value) => _imageUrl = value,
        ),
        SizedBox(height: 7.h),
        DropdownButton<String>(
          hint: Text('Select Category'),
          value: _selectedCategory,
          items: _categories.map((category) {
            return DropdownMenuItem(value: category, child: Text(category));
          }).toList(),
          onChanged: (value) => setState(() => _selectedCategory = value),
        ),
        SizedBox(height: 7.h),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xffD2D2D2)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: Color(0xFF007AFF), width: 1.5.w),
        ),
      ),
    );
  }
}
