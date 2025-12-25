import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/app/core/widgets/skeletons/redacted_box.dart';
import 'package:lawaen/app/core/widgets/skeletons/shimmer_container.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/cubit/notification/notification_cubit.dart';
import 'package:lawaen/generated/locale_keys.g.dart';

import 'notification_item.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listenWhen: (prev, curr) => prev.listState != curr.listState,
      listener: (context, state) {
        if (state.listState == RequestState.error && !state.isLoadMoreNotifications) {
          alertDialog(
            context: context,
            message: state.listError ?? "",
            isError: true,
            onConfirm: () => context.read<NotificationCubit>().getNotifications(),
          );
        }
      },
      builder: (context, state) {
        if (state.listState == RequestState.loading && !state.isLoadMoreNotifications) {
          return const _NotificationsListSkeleton(count: 6);
        }

        if (state.listState == RequestState.success || state.isLoadMoreNotifications) {
          final items = state.notifications;

          if (items.isEmpty && !state.isLoadMoreNotifications) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100.h),
                  child: Text(LocaleKeys.noNotifications.tr(), style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
            );
          }

          return SliverList.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final n = items[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: NotificationItem(notification: n),
              );
            },
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _NotificationsListSkeleton extends StatelessWidget {
  final int count;

  const _NotificationsListSkeleton({this.count = 6});

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
