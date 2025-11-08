import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class OpenMapWidget extends StatelessWidget {
  const OpenMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: AspectRatio(
        aspectRatio: 1.5,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Image.asset(ImageManager.map, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            ),
            Positioned(
              bottom: 10.h,
              left: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, offset: const Offset(0, 2))],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(IconManager.send, width: 16.w, height: 16.h),
                    SizedBox(width: 5.w),
                    Text(
                      'Open Interactive Map',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(color: ColorManager.primary, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
