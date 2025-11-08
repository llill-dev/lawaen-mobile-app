import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import '../../../../../../app/resources/assets_manager.dart';

class EventItem extends StatelessWidget {
  final String image;
  final String day;
  final String month;
  final String title;
  final void Function()? goToNextPage;
  const EventItem({
    super.key,
    required this.image,
    required this.day,
    required this.month,
    required this.title,
    this.goToNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 12.h,
            left: 7.w,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(day, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
                  Text(month, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.primary.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white)),
            ),
          ),
          Positioned(
            bottom: 12.h,
            right: 12.w,
            child: GestureDetector(
              onTap: goToNextPage,
              child: CircleAvatar(
                backgroundColor: ColorManager.lightGrey,
                radius: 13.r,
                child: SvgPicture.asset(IconManager.forward),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
