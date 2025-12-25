import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/di/injection.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/notification/notification_cubit.dart';

import '../../../../app/core/utils/functions.dart';
import 'widgets/notification/notification_app_bar.dart';
import 'widgets/notification/notifications_list.dart';
import 'widgets/notification/recent_notification.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationCubit>()..getNotifications(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: NotificationAppBar()),
              buildSpace(),
              SliverToBoxAdapter(child: RecentNotifications().horizontalPadding(padding: 16.w)),
              buildSpace(),
              const NotificationsList(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationsListSkeleton extends StatelessWidget {
  final int count;

  const NotificationsListSkeleton({super.key, this.count = 6});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: RedactedBox(
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
                  ShimmerBox(width: 52.w, height: 52.w, borderRadius: BorderRadius.circular(14.r)),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerBox(width: 180.w, height: 14.h),
                        10.verticalSpace,
                        ShimmerBox(width: double.infinity, height: 12.h),
                        8.verticalSpace,
                        Row(
                          children: [
                            ShimmerBox(width: 14.w, height: 14.w, borderRadius: BorderRadius.circular(4.r)),
                            6.horizontalSpace,
                            ShimmerBox(width: 90.w, height: 12.h),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
