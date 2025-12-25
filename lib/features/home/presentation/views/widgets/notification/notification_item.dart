import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/functions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/data/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final title = (notification.title ?? "").trim();
    final body = (notification.body ?? "").trim();
    final timeText = notificationTimeLabel(notification.createdAt);

    final isUnread = (notification.isRead ?? false) == false;

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
                borderRadius: BorderRadius.circular(14.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              child: Center(
                child: (notification.imageUrl != null && notification.imageUrl!.trim().isNotEmpty)
                    ? NetworkIcon(url: notification.imageUrl!, width: 24.w, height: 24.w, fit: BoxFit.contain)
                    : SvgPicture.asset(IconManager.discount, width: 24.w, height: 24.w),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.isEmpty ? "-" : title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  6.verticalSpace,
                  Text(
                    body.isEmpty ? "-" : body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      SvgPicture.asset(IconManager.clock),
                      4.horizontalSpace,
                      if (timeText.isNotEmpty) Text(timeText, style: Theme.of(context).textTheme.headlineSmall),
                    ],
                  ),
                ],
              ),
            ),
            if (isUnread) ...[
              10.horizontalSpace,
              Container(
                width: 10.w,
                height: 10.w,
                decoration: const BoxDecoration(color: ColorManager.orange, shape: BoxShape.circle),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
