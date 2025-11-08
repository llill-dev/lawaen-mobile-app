import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../app/resources/assets_manager.dart';
import '../../../../../../app/routes/router.gr.dart';

class HomeAppBarHeaderSection extends StatelessWidget {
  final bool showNotificationIcon;
  const HomeAppBarHeaderSection({super.key, this.showNotificationIcon = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(ImageManager.logo),
            if (showNotificationIcon)
              CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.2),

                child: IconButton(
                  icon: SvgPicture.asset(IconManager.notification),
                  onPressed: () {
                    context.router.push(NotificationRoute());
                  },
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            SvgPicture.asset(IconManager.location),
            SizedBox(width: 4.w),
            Text('syria, Damascus', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
