import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class CategoryItem extends StatelessWidget {
  final String count;
  final String name;
  final String image;
  final bool isLoading;
  const CategoryItem({super.key, required this.count, required this.name, required this.image, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(CategoryDetailsRoute()),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withValues(alpha: .25),
              spreadRadius: -1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: ColorManager.black.withValues(alpha: .25),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? ShimmerBox(width: 50.w, height: 50.w, borderRadius: BorderRadius.circular(50))
                : NetworkIcon(url: image, size: 50.w),

            SizedBox(height: 8.h),

            isLoading
                ? ShimmerBox(width: 35.w, height: 10.h, borderRadius: BorderRadius.circular(4))
                : Text(count, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12)),

            SizedBox(height: 6.h),

            isLoading
                ? ShimmerBox(width: 50.w, height: 10.h, borderRadius: BorderRadius.circular(4))
                : Text(name, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
