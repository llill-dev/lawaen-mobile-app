import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.isNew});

  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(NotificationDetailsRoute()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: ColorManager.white,
          border: Border.all(color: ColorManager.notificationBorderColor, width: 1.9),
        ),
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorManager.primarySwatch[100],
                borderRadius: BorderRadius.circular(14),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Center(child: SvgPicture.asset(IconManager.discount)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Special Discount Available!", style: Theme.of(context).textTheme.headlineMedium),
                  6.verticalSpace,
                  Text(
                    "Your hotel reservation at Banyan Tree Dubai has been confirmed",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isNew ? ColorManager.orange.withValues(alpha: .7) : ColorManager.lightGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          "offer",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
                        ),
                      ),
                      8.horizontalSpace,
                      Text("Shopping •", style: Theme.of(context).textTheme.headlineSmall),
                      8.horizontalSpace,
                      SvgPicture.asset(IconManager.clock),
                      4.horizontalSpace,
                      Text("2 hours ago", style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
