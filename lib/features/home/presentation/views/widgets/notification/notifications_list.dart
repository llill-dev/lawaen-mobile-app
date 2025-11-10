import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/resources/color_manager.dart';

import 'notification_item.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        final bool isNew = index.isEven;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              NotificationItem(isNew: isNew),
              if (isNew)
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(color: ColorManager.orange, shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
