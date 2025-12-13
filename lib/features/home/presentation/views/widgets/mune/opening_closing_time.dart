import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

class OpeningClosingTime extends StatelessWidget {
  final String openColseTimes;
  const OpeningClosingTime({super.key, required this.openColseTimes});

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
            _buildTimeText(time: "${LocaleKeys.openingHours.tr()} | $openColseTimes", context: context),
            10.verticalSpace,
            // _buildTimeText(time: "Reservations recommended | (555) 123-4567", context: context),
          ],
        ),
      ).horizontalPadding(padding: 16.w),
    );
  }

  Widget _buildTimeText({required String time, required BuildContext context}) {
    return Text(time, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.darkGrey));
  }
}
