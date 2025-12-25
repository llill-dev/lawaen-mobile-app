import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/core/utils/enums.dart';
import 'package:lawaen/app/core/widgets/alert_dialog.dart';
import 'package:lawaen/features/home/presentation/cubit/notification/notification_cubit.dart';
import 'package:lawaen/features/home/presentation/views/notification_screen.dart';

import 'notification_item.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listenWhen: (prev, curr) => prev.listState != curr.listState,
      listener: (context, state) {
        if (state.listState == RequestState.error) {
          alertDialog(
            context: context,
            message: state.listError ?? "",
            isError: true,
            onConfirm: () => context.read<NotificationCubit>().getNotifications(),
          );
        }
      },
      builder: (context, state) {
        if (state.listState == RequestState.loading) {
          return const NotificationsListSkeleton(count: 6);
        }

        if (state.listState == RequestState.success) {
          final items = state.notifications;

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

        // idle / default
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
