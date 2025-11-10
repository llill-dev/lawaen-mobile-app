import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/resources/assets_manager.dart';

class HeaderImageSection extends StatelessWidget {
  const HeaderImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorManager.categoryItemDetailsGradinet.withValues(alpha: 0.5),
                  ColorManager.categoryItemDetailsGradinet.withValues(alpha: 0.7),
                  ColorManager.categoryItemDetailsGradinet,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.asset(ImageManager.catItem, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Positioned(
            top: 50.h,
            left: 15.w,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(Icons.arrow_back, color: ColorManager.white, size: 18.r),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Banyan Tree Damascus",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: ColorManager.white),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(color: ColorManager.red, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Text(
                            "closed now",
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: ColorManager.white, size: 18.r),
                        ],
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      "9:00AM - 6:00PM",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.lightGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
