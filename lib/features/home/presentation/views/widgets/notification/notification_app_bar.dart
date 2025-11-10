import 'package:flutter/material.dart';
import 'package:lawaen/app/resources/color_manager.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_container.dart';
import 'package:lawaen/features/home/presentation/views/widgets/home_app_bar/home_app_bar_header_section.dart';

import '../../../../../../app/core/widgets/primary_back_button.dart';

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
              PrimaryBackButton(),
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
