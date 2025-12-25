import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/features/home/presentation/cubit/notification/notification_cubit.dart';

import '../../../../app/core/utils/functions.dart';
import 'widgets/notification/notification_app_bar.dart';
import 'widgets/notification/notifications_list.dart';
import 'widgets/notification/recent_notification.dart';

@RoutePage()
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _cubit = context.read<NotificationCubit>();
    _cubit.getNotifications();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.extentAfter < 400) {
      _cubit.getNotifications(isLoadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            const SliverToBoxAdapter(child: NotificationAppBar()),
            buildSpace(),
            SliverToBoxAdapter(child: RecentNotifications().horizontalPadding(padding: 16.w)),
            buildSpace(),
            const NotificationsList(),
          ],
        ),
      ),
    );
  }
}
