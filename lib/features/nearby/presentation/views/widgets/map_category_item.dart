import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/category_model.dart';

class MapCategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final bool isLoading;
  final VoidCallback onTap;

  const MapCategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? ColorManager.primary : ColorManager.lightGrey;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.all(12.w),
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: .12),
              spreadRadius: -1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? ShimmerBox(width: 40.w, height: 40.w, borderRadius: BorderRadius.circular(40))
                : NetworkIcon(url: category.image, size: 40.w),

            SizedBox(height: 6.h),

            isLoading
                ? ShimmerBox(width: 30.w, height: 8.h, borderRadius: BorderRadius.circular(4))
                : Text(
                    category.totalCategoryCount.toString(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 11),
                  ),

            SizedBox(height: 4.h),

            isLoading
                ? ShimmerBox(width: 60.w, height: 8.h, borderRadius: BorderRadius.circular(4))
                : Text(
                    category.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 11),
                  ),
          ],
        ),
      ),
    );
  }
}
