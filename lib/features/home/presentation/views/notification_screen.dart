import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lawaen/app/extensions.dart';
import 'package:lawaen/app/resources/assets_manager.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/app/routes/router.gr.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_header_section.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: NotificationAppBar()),
            _buildSpace(),
            SliverToBoxAdapter(child: RecentNotifications().horizontalPadding(padding: 16.w)),
            _buildSpace(),
            NotificationsList(),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpace() {
    return SliverToBoxAdapter(child: SizedBox(height: 16));
  }
}

class RecentNotifications extends StatelessWidget {
  const RecentNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Recent Notifications", style: Theme.of(context).textTheme.headlineMedium),
        6.horizontalSpace,
        Container(
          decoration: BoxDecoration(
            color: ColorManager.orange.withValues(alpha: .7),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text("3 new", style: Theme.of(context).textTheme.headlineMedium),
        ),
        6.horizontalSpace,
        Row(
          children: [
            SvgPicture.asset(IconManager.check),
            3.horizontalSpace,
            Text(
              "Mark all as read",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.primary),
            ),
          ],
        ),
      ],
    );
  }
}

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeAppBarContainer(
      child: Column(
        children: [
          HomeAppBarHeaderSection(showNotificationIcon: false),
          SizedBox(height: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: ColorManager.primary, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'back',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: ColorManager.primary),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: ColorManager.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
              GestureDetector(
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
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall?.copyWith(color: ColorManager.black),
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
              ),
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
