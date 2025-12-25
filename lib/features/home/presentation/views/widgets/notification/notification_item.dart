import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/core/helper/network_icon.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/functions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/data/models/notification_model.dart';
import 'package:lawaen/features/home/presentation/cubit/notification/notification_cubit.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    final title = (notification.title ?? "").trim();
    final body = (notification.body ?? "").trim();
    final timeText = notificationTimeLabel(notification.createdAt);
    final isUnread = (notification.isRead ?? false) == false;

    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final isLoading = state.markReadState == RequestState.loading && state.markReadLoadingId == notification.id;

        return GestureDetector(
          onTap: isLoading ? null : () => context.read<NotificationCubit>().markAsRead(notification.id!),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: isLoading ? 0.7 : 1.0,
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
                  // Icon/Image
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
                        // Title
                        Text(
                          title.isEmpty ? "-" : title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        6.verticalSpace,

                        // Body
                        Text(
                          body.isEmpty ? "-" : body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        8.verticalSpace,

                        // Time
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

                  // Right-side indicator (unread dot OR loader)
                  10.horizontalSpace,
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                    child: isLoading
                        ? _InlineLoading(key: const ValueKey('loading'))
                        : (isUnread
                              ? Container(
                                  key: const ValueKey('dot'),
                                  width: 10.w,
                                  height: 10.w,
                                  decoration: const BoxDecoration(color: ColorManager.orange, shape: BoxShape.circle),
                                )
                              : const SizedBox(key: ValueKey('empty'), width: 10, height: 10)),
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

class _InlineLoading extends StatelessWidget {
  const _InlineLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      height: 18.w,
      child: const CircularProgressIndicator(strokeWidth: 2, color: ColorManager.primary),
    );
  }
}
