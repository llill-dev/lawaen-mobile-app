import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class OpeningClosingTime extends StatelessWidget {
  const OpeningClosingTime({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: ColorManager.green.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildTimeText(time: "Open Tuesday - Sunday | 5:00 PM - 10:00 PM", context: context),
            10.verticalSpace,
            _buildTimeText(time: "Reservations recommended | (555) 123-4567", context: context),
          ],
        ),
      ).horizontalPadding(padding: 16.w),
    );
  }

  Widget _buildTimeText({required String time, required BuildContext context}) {
    return Text(time, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.darkGrey));
  }
}
