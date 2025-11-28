import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';

import 'category_item.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: .8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return CategoryItem(image: item.image, name: item.name, count: item.totalCategoryCount.toString());
        },
      ),
    );
  }
}
