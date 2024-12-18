import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoppe/controllers/category_controller.dart';
import 'package:shoppe/models/category_model.dart';
import 'package:shoppe/utils/button.dart';
import 'package:shoppe/utils/text_field.dart';

class ManageCategoryView extends StatefulWidget {
  const ManageCategoryView({super.key});

  @override
  State<ManageCategoryView> createState() => _ManageCategoryViewState();
}

class _ManageCategoryViewState extends State<ManageCategoryView> {
  final CategoryController _categoryController = CategoryController();
  TextEditingController _nameController = TextEditingController();

  // Predefined list of local assets for category images
  final List<String> _categoryImages = [
    'assets/categories/electronics.webp',
    'assets/categories/clothing.webp',
  ];

  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextField(
                    hintText: 'Category Name', controller: _nameController),
                SizedBox(height: 20.h),
                DropdownButtonFormField(
                  dropdownColor: Colors.white,
                  value: _selectedImage,
                  decoration: InputDecoration(
                    labelText: 'Select image',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF007AFF),
                          width: 2), // Border color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF007AFF),
                          width: 2), // Border color when focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF007AFF),
                          width: 2), // Default border color
                    ),
                  ),
                  items: _categoryImages.map((imagePath) {
                    return DropdownMenuItem(
                      value: imagePath,
                      child: Row(
                        children: [
                          Image.asset(imagePath, width: 40, height: 40),
                          SizedBox(width: 8),
                          Text(imagePath.split('/').last), // Display file name
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedImage = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                CustomButton('Add', _addCategory),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Divider(),
          SizedBox(height: 20.h),
          Text(
            'Categories List',
            style: TextStyle(fontFamily: 'TitleBold', fontSize: 32.sp),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: StreamBuilder<List<CategoryModel>>(
              stream: _categoryController.getCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text('Error fetching categories'));
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final categories = snapshot.data!;
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () => _updateCategory(category),
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        child: ListTile(
                          leading: Image.asset(category.imagePath,
                              width: 50, height: 50),
                          title: Text(category.name),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _categoryController.deleteCategory(category.id);
                              const snackBar = SnackBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: AwesomeSnackbarContent(
                                  title: 'Deleted',
                                  message: 'Category Successfully Deleted',
                                  contentType: ContentType.warning,
                                  color: Colors.red,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
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
        "Manage Categories",
        style: TextStyle(fontFamily: "TitleBold"),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  void _addCategory() async {
    if (_nameController.text.isNotEmpty && _selectedImage != null) {
      final category = CategoryModel(
          id: DateTime.now().toString(),
          name: _nameController.text.trim(),
          imagePath: _selectedImage!);

      await _categoryController.addCategory(category);
      _nameController.clear();
      setState(() => _selectedImage = null);

      const snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: AwesomeSnackbarContent(
          title: 'Added',
          message: 'Category Successfully added',
          contentType: ContentType.success,
          color: Color(0xFF007AFF),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void _updateCategory(CategoryModel category) async {
    _nameController.text = category.name;
    _selectedImage = category.imagePath;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Update Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            SizedBox(height: 20.h),
            DropdownButton<String>(
              hint: Text('Select Image'),
              value: _selectedImage,
              items: _categoryImages.map((imagePath) {
                return DropdownMenuItem(
                  value: imagePath,
                  child: Row(
                    children: [
                      Image.asset(imagePath, width: 40, height: 40),
                      SizedBox(width: 8),
                      Text(imagePath.split('/').last),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedImage = value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isNotEmpty && _selectedImage != null) {
                final updatedCategory = CategoryModel(
                  id: category.id,
                  name: _nameController.text.trim(),
                  imagePath: _selectedImage!,
                );
                await _categoryController.updateCategory(updatedCategory);
                Navigator.pop(context);
                _nameController.clear();
                setState(() => _selectedImage = null);
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
