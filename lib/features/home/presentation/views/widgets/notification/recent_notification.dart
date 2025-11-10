import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';

class RecentNotifications extends StatelessWidget {
  const RecentNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Recent Notifications", style: Theme.of(context).textTheme.headlineMedium),
        6.horizontalSpace,
        Container(
          decoration: BoxDecoration(
            color: ColorManager.orange.withValues(alpha: .7),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text("3 new", style: Theme.of(context).textTheme.headlineMedium),
        ),
        6.horizontalSpace,
        Row(
          children: [
            SvgPicture.asset(IconManager.check),
            3.horizontalSpace,
            Text(
              "Mark all as read",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary),
            ),
          ],
        ),
      ],
    );
  }
}
