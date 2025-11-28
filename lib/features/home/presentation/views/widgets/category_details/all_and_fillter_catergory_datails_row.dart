import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';
import 'package:lawaen/features/home/presentation/views/widgets/category_details/filter_category_info.dart';

class AllAndFilterCategoryDetailsRow extends StatelessWidget {
  final List<SecondCategory> secondCategory;
  const AllAndFilterCategoryDetailsRow({super.key, required this.secondCategory});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(color: ColorManager.primary, borderRadius: BorderRadius.circular(10.r)),
            child: Text("All", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white)),
          ),
          8.horizontalSpace,
          GestureDetector(
            onTap: () => _showFilterBottomSheet(context, secondCategory.map((e) => e.name).toList()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(color: ColorManager.lightGrey, borderRadius: BorderRadius.circular(10.r)),
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
    );
  }

  void _showFilterBottomSheet(BuildContext context, List<String> subCategories) {
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
