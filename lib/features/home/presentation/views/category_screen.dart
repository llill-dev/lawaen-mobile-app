import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';

import '../../../../app/core/utils/functions.dart';
import '../../../../app/core/widgets/primary_back_button.dart';
import 'widgets/category/category_list.dart';
import 'widgets/home_app_bar/home_app_bar.dart';

@RoutePage()
class CategoryScreen extends StatelessWidget {
  final List<CategoryModel> categories;
  const CategoryScreen({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
            SliverToBoxAdapter(child: HomeAppBar()),
            buildSpace(),
            SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: PrimaryBackButton(withShadow: true, width: 75.w).horizontalPadding(padding: 16.w),
              ),
            ),
            buildSpace(),
            CategoryList(categories: categories),
            buildSpace(height: 50.h),
          ],
        ),
      ),
    );
  }
}
