import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../../../app/resources/assets_manager.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  const CategoryItem({super.key, required this.index});

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
            SvgPicture.asset(IconManager.chair),
            SizedBox(height: 6.h),
            Text('$index.5K', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 12)),
            SizedBox(height: 6.h),
            Text('Category ${index + 1}', style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
