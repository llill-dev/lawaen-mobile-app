import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class StepsHeader extends StatelessWidget {
  final int currentStep;
  final List<String> titles;

  const StepsHeader({super.key, required this.currentStep, required this.titles});

  @override
  Widget build(BuildContext context) {
    final total = titles.length;

    return SizedBox(
      height: 90.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: List.generate(total, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep;
            return Row(
              children: [
                _StepItem(index: index, title: titles[index], isCurrent: isCurrent, isCompleted: isCompleted),
                if (index != total - 1)
                  Container(
                    width: 25.w,
                    height: 2.h,
                    color: isCurrent ? ColorManager.primary : ColorManager.lightGrey,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final int index;
  final String title;
  final bool isCurrent;
  final bool isCompleted;

  const _StepItem({required this.index, required this.title, required this.isCurrent, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    Color circleColor;
    Widget innerChild;

    if (isCompleted) {
      circleColor = ColorManager.green;
      innerChild = const Icon(Icons.check, size: 14, color: ColorManager.white);
    } else if (isCurrent) {
      circleColor = ColorManager.primary;
      innerChild = Text(
        '${index + 1}',
        style: TextStyle(color: ColorManager.white, fontWeight: FontWeight.bold, fontSize: 12.sp),
      );
    } else {
      circleColor = ColorManager.lightGrey;
      innerChild = Text(
        '${index + 1}',
        style: TextStyle(color: ColorManager.grey, fontWeight: FontWeight.bold, fontSize: 12.sp),
      );
    }

    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
            alignment: Alignment.center,
            child: innerChild,
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              height: 1.2,
              color: isCurrent ? ColorManager.primary : ColorManager.blackSwatch[9],
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
