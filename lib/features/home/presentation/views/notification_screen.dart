import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';

import '../../../../app/core/utils/functions.dart';
import 'widgets/notification/notification_app_bar.dart';
import 'widgets/notification/notifications_list.dart';
import 'widgets/notification/recent_notification.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: NotificationAppBar()),
            buildSpace(),
            SliverToBoxAdapter(child: RecentNotifications().horizontalPadding(padding: 16.w)),
            buildSpace(),
            NotificationsList(),
          ],
        ),
      ),
    );
  }
}
