import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class EventsItem extends StatelessWidget {
  final bool isGridView;
  const EventsItem({super.key, required this.isGridView});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16.r);
    final content = ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(ImageManager.events, fit: isGridView ? BoxFit.cover : BoxFit.cover)),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: .7),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("10", style: Theme.of(context).textTheme.displayLarge?.copyWith(color: ColorManager.white)),
                  4.verticalSpace,
                  Text("Jun", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white)),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(color: ColorManager.primary.withValues(alpha: .7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fairuz and the love",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.white),
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconManager.location,
                        colorFilter: ColorFilter.mode(ColorManager.green, BlendMode.srcIn),
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: Text(
                          "Aleppo",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorManager.green),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (isGridView) {
      return content;
    }

    return SizedBox(height: 170.h, width: double.infinity, child: content);
  }
}
