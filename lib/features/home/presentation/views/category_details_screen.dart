import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/core/utils/functions.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar.dart';

import '../../../../app/core/widgets/primary_back_button.dart';
import '../../../../app/resources/color_manager.dart';
import 'widgets/category_details/category_info_list.dart';
import 'widgets/category_details/filter_category_info.dart';

@RoutePage()
class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SliverToBoxAdapter(
              child: Text("Docotrs:", style: Theme.of(context).textTheme.bodyLarge).horizontalPadding(padding: 16.w),
            ),
            buildSpace(),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(10.r)),
                    child: Text(
                      "All",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                    ),
                  ),
                  8.horizontalSpace,
                  GestureDetector(
                    onTap: () => _showFilterBottomSheet(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGrey,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(IconManager.filter),
                          6.horizontalSpace,
                          Text("filter", style: Theme.of(context).textTheme.headlineSmall),
                        ],
                      ),
                    ),
                  ),
                ],
              ).horizontalPadding(padding: 16.w),
            ),
            buildSpace(),
            CategoryInofList(),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final List<String> subCategories = ["Dentist", "Cardiologist", "Children", "Eye Specialist", "Dermatologist"];
    final ValueNotifier<Set<String>> selected = ValueNotifier<Set<String>>({});
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) {
        return FilterCategoryInfo(selected: selected, subCategories: subCategories);
      },
    );
  }
}
