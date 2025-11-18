import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class NoItemAddedContainer extends StatelessWidget {
  final String title;
  const NoItemAddedContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      height: 130.h,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: ColorManager.blackSwatch[4]!, width: 2),
      ),
      child: Center(
        child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
      ),
    ).horizontalPadding(padding: 16.w);
  }
}
