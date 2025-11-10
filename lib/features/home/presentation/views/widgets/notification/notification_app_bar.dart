import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_header_section.dart';

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
