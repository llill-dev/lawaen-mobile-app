import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

import '../../../../../../app/resources/color_manager.dart';

class CategoryInofList extends StatelessWidget {
  const CategoryInofList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: 4,
      separatorBuilder: (context, index) => 10.verticalSpace,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => context.router.push(CategoryItemDetialsRoute()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.borderColor),
              color: ColorManager.white,
              boxShadow: [
                BoxShadow(color: ColorManager.black.withValues(alpha: .15), blurRadius: 3, offset: Offset(0, 1)),
              ],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset(ImageManager.cat)),
                18.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dr.Rama Rama", style: Theme.of(context).textTheme.headlineMedium),
                      8.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("dentist", style: Theme.of(context).textTheme.headlineSmall),
                          Row(
                            children: [
                              SvgPicture.asset(IconManager.location, color: ColorManager.green),
                              2.horizontalSpace,
                              Text(
                                "Hama",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).horizontalPadding(padding: 16.w),
        );
      },
    );
  }
}
