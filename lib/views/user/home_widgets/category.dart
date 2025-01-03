import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';
import '../../../utils/constants.dart';


class CategoryButton extends StatefulWidget {
  const CategoryButton({super.key});

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  final CategoryController _categoryController = CategoryController();
  int selectedIndex = 0; // To track the selected chip

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: StreamBuilder<List<CategoryModel>>(
          stream: _categoryController.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text('Error fetching categories'));
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            final categories = snapshot.data!;
            return Container(
              height: 40.h,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final bool isSelected = selectedIndex == index;
                  return Container(
                    margin: EdgeInsets.only(right: 6.w),
                    child: ChoiceChip(
                      showCheckmark: false,
                      label: Text(
                        category.name,
                        style: TextStyle(
                            fontFamily: 'TextRegular',
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      selected: isSelected,
                      selectedColor: primaryColor,
                      backgroundColor: Colors.white,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}